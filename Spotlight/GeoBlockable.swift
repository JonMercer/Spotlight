//
//  GeoBlockable.swift
//  Spotlight
//
//  Created by Odin on 2016-08-02.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

protocol GeoBlockable {
    func getGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey
    func getGeoBlock(loc: CLLocationDegrees) -> CLLocationIntegers
    
    func downloadGeoBlockKeysFromNeighbouringBigGeoBlocks(lat: CLLocationDegrees, lon: CLLocationDegrees, completed:(geoBlockKeys: [GeoBlockKey]?, err: ErrorType?) -> ())

    func downloadPhotoInfoKeysInGeoBlocks(geoBlockKeys: [GeoBlockKey], completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ())
    
    func sortGeoBlocksByDistance(geoBlockKeys: [GeoBlockKey], lat: CLLocationDegrees, lon: CLLocationDegrees) -> [GeoBlockKey]
}

extension GeoBlockable {
    func getGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey {
        // Needed to multiply by 1000 because keys cannot contain '.'
        let latString = formatGeoBlockKey(getGeoBlock(lat))
        let lonString = formatGeoBlockKey(getGeoBlock(lon))
        return "\(latString)_\(lonString)"
    }
    
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey {
        let bigLatString = formatBigGeoBlockKey(getGeoBlock(lat))
        let bigLonString = formatBigGeoBlockKey(getGeoBlock(lon))
        return "\(bigLatString)_\(bigLonString)"
    }
    
    // PURPOSE: We wanted to split up the world in 0.005 (lat lon) increments.
    //          ex: So 1.12345 = 1.12000
    //                 1.23879 = 1.23500
    //                 -1.12345 = -1.12500
    //                 -1.23879 = -1.24000
    func getGeoBlock(loc: CLLocationDegrees) -> Int {
        //did not want to work with doubles because -4.5 is technically -4.50000000001
        let locInt = Int(loc * 1000)
        
        if (loc % 5) == 0 {
            return locInt
        }
        
        //if the number is close to x.xx5xxx
        if (locInt % 5) == 0 && locInt > 0 {
            return locInt
        }
        
        //if the number is close to -x.xx50000 and -x.xx50001. This is here because of ceiling problems
        if (locInt % 5) == 0 && locInt < 0 && (Double(locInt) - (loc * 1000) < 0.0000001) {
            return locInt
        }
        
        //this is the '#' in 123.45#789
        let lastDigit = (locInt % 10)
        
        //positive numbers are floored such that the last digit is a 0 or a 5
        if loc >= 0 {
            if lastDigit >= 0 && lastDigit < 5 {
                return locInt - lastDigit
            } else {
                return locInt - lastDigit + 5
            }
        }
            //negative numbers are ceilinged such that the last digit is a 0 or a 5
        else {
            //if the number ends in a 5, assume that its not 0.00500000
            if lastDigit <= 0 && lastDigit > -5 {
                return locInt - lastDigit - 5
            } else {
                return locInt - lastDigit - 10
            }
        }
    }
    
    
    
    //MARK: - DownloadInterface related
    
    func downloadGeoBlockKeysFromNeighbouringBigGeoBlocks(lat: CLLocationDegrees, lon: CLLocationDegrees, completed:(geoBlockKeys: [GeoBlockKey]?, err: ErrorType?) -> ()) {
        var geoBlockKeysInNeighbouringBigBlocks = [GeoBlockKey]()
        
        let neighbouringBigGeoBlocks = getNeighbouringBigGeoBlockKeys(lat, lon: lon)
        
        var counter: Int = 0
        for bigGeoBlockKey in neighbouringBigGeoBlocks {
            self.downloadGeoBlockKeysFromBigGeoBlock(bigGeoBlockKey, completed: { (geoBlockKeys, err) in
                guard err == nil else {
                    Log.debug("could not get geoblocks from \(bigGeoBlockKey)")
                    completed(geoBlockKeys: nil, err: err)
                    return
                }
                
                geoBlockKeysInNeighbouringBigBlocks.appendContentsOf(geoBlockKeys!)
                counter = counter + 1
                
                if counter == neighbouringBigGeoBlocks.count {
                    completed(geoBlockKeys: geoBlockKeysInNeighbouringBigBlocks, err: nil)
                }
            })
        }
    }
    
    func downloadPhotoInfoKeysInGeoBlocks(geoBlockKeys: [GeoBlockKey], completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ()) {
        var listOfPhotoInfoKeysToReturn = [PhotoInfoKey]()
        
        // to handle async calls
        var counter: Int = 0;
        for geoBlockKey in geoBlockKeys {
            downloadPhotoKeysFromGeoBlock(geoBlockKey, completed: { (photoInfoKeys, err) in
                guard err == nil else {
                    Log.debug("could not photo info keys from \(geoBlockKey)")
                    completed(photoInfoKeys: nil, err: err)
                    return
                }
                
                listOfPhotoInfoKeysToReturn.appendContentsOf(photoInfoKeys!)
                counter = counter + 1
                
                if(counter == geoBlockKeys.count) {
                    completed(photoInfoKeys: listOfPhotoInfoKeysToReturn, err: nil)
                }
            })
        }
    }

    
    func sortGeoBlocksByDistance(geoBlockKeys: [GeoBlockKey], lat: CLLocationDegrees, lon: CLLocationDegrees) -> [GeoBlockKey] {
        let currentGeoBlockKey = self.getGeoBlockKey(lat, lon: lon)
        
        // [Radius (manhattan distance from the center): list of geoBlocks]
        var geoBlockDictionary = [Int: [GeoBlockKey]]()
        
        // Populate the dictionary
        for geoBlockKey in geoBlockKeys {
            let geoBlockRadius = self.calculateGeoRadius(self.extractGeoBlockKeyLatLon(currentGeoBlockKey), b: self.extractGeoBlockKeyLatLon(geoBlockKey))
            
            if geoBlockDictionary[geoBlockRadius] == nil {
                geoBlockDictionary[geoBlockRadius] = [GeoBlockKey]()
            }
            
            var listAtGeoBlockRadius = geoBlockDictionary[geoBlockRadius]
            listAtGeoBlockRadius?.append(geoBlockKey)
            
            geoBlockDictionary[geoBlockRadius] = listAtGeoBlockRadius
        }
        
        // Sort everything in the dictionary by manhattan distance
        let sortedGeoBlockRadii = geoBlockDictionary.keys.sort()
        var sortedGeoBlockKeysToReturn = [GeoBlockKey]()
        
        for geoBlockRadius in sortedGeoBlockRadii {
            var geoBlocksWithinRadius = geoBlockDictionary[geoBlockRadius]
            geoBlocksWithinRadius?.sortInPlace()
            if geoBlocksWithinRadius != nil {
                sortedGeoBlockKeysToReturn += geoBlocksWithinRadius!
            } else {
                Log.error("GeoBlockRadius: \(geoBlockRadius) is not supposed to be nil in dictionary")
                //TODO: consider throwing an error
            }
        }
        
        return sortedGeoBlockKeysToReturn
    }
    
    
    //MARK: - Private helper functions
    
    private func formatGeoBlockKey(locInt: CLLocationIntegers) -> String {
        if locInt < 0 {
            return String(format: "%07d", locInt)
        } else {
            return String(format: "%06d", locInt)
        }
    }
    
    private func formatBigGeoBlockKey(locInt: CLLocationIntegers) -> String {
        let roundedLoc = Int(floor(Double(locInt)/1000))
        if roundedLoc < 0 {
            return String(format: "%04d", roundedLoc)
        } else {
            return String(format: "%03d", roundedLoc)
        }
    }
    
    private func getNeighbouringBigGeoBlockKeys(lat: CLLocationDegrees, lon: CLLocationDegrees) -> [BigGeoBlockKey] {
        var neighbouringBigGeoBlocks = [BigGeoBlockKey]()
        
        for i in -1...1 {
            for j in -1...1 {
                let latNeighbour = lat + Double(i)
                let lonNeighbour = lon + Double(j)
                
                let bigBlockKey = self.getBigGeoBlockKey(latNeighbour, lon: lonNeighbour)
                
                neighbouringBigGeoBlocks.append(bigBlockKey)
            }
        }
        
        return neighbouringBigGeoBlocks
    }
    
    private func downloadGeoBlockKeysFromBigGeoBlock(bigGeoBlockKey: BigGeoBlockKey, completed:(geoBlockKeys: [GeoBlockKey]?, err: ErrorType?) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child(PermanentConstants.realTimeDatabaseBigGeoBlock).child(bigGeoBlockKey).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [GeoBlockKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completed(geoBlockKeys: listOfKeys, err: nil)
            } else {
                Log.debug("List of children is empty")
                let emptyList = [GeoBlockKey]()
                
                completed(geoBlockKeys: emptyList, err: nil)
            }
            
        }) { (error) in
            Log.debug(error.localizedDescription)
            completed(geoBlockKeys: nil, err: error)
        }
    }
    
    private func downloadPhotoKeysFromGeoBlock(geoBlockKey: GeoBlockKey, completed:(photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child(PermanentConstants.realTimeDatabaseGeoBlock).child(geoBlockKey).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [PhotoInfoKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completed(photoInfoKeys: listOfKeys, err: nil)
            } else {
                Log.debug("List of children is empty")
                completed(photoInfoKeys: nil, err: DownloadError.EmptyGeoBlock)
            }
            
        }) { (error) in
            Log.debug(error.localizedDescription)
            completed(photoInfoKeys: nil, err: error)
        }
    }
    
    
    private func calculateGeoRadius(a: (Int, Int), b: (Int, Int)) -> Int {
        return max(abs(a.0-b.0), abs(a.1-b.1))
    }
    
    private func extractGeoBlockKeyLatLon(geoBlockKey: GeoBlockKey) -> (Int, Int) {
        let geoBlocksLocs = geoBlockKey.componentsSeparatedByString("_")
        
        return (Int(geoBlocksLocs[0])!,Int(geoBlocksLocs[1])!)
    }
}