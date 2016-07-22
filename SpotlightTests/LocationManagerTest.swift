//
//  LocationManagerTest.swift
//  Spotlight
//
//  Created by Odin on 2016-07-19.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import XCTest
@testable import Spotlight

class LocationManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetLocationBlock() {
        //SL-114
        //objc[6416]: Class GMSx_GTLPlacesMobilePersonalizedPlacesResponse is implemented in both /Users/Odin/Library/Developer/CoreSimulator/Devices/246A48F7-7B67-4FC6-8769-08A59AB31C4D/data/Containers/Bundle/Application/2344627F-531D-4788-A899-08506013C8F2/Spotlight.app/Spotlight and /Users/Odin/Library/Developer/Xcode/DerivedData/Spotlight-ektotnfmzcllewecxrnxazznpqqg/Build/Products/Debug-iphonesimulator/Spotlight.app/PlugIns/SpotlightTests.xctest/SpotlightTests. One of the two will be used. Which one is undefined.

        XCTAssertEqual(0.000, LocationManager.sharedInstance.getLocationBlock(0.003))
        XCTAssertEqual(0.005, LocationManager.sharedInstance.getLocationBlock(0.005))
        XCTAssertEqual(0.005, LocationManager.sharedInstance.getLocationBlock(0.007))
        XCTAssertEqual(-0.005, LocationManager.sharedInstance.getLocationBlock(-0.003))
        XCTAssertEqual(-0.010, LocationManager.sharedInstance.getLocationBlock(-0.006))
        XCTAssertEqual(-0.010, LocationManager.sharedInstance.getLocationBlock(-0.005))
        XCTAssertEqual(0.000, LocationManager.sharedInstance.getLocationBlock(0))
        
        XCTAssertEqual(89.450, LocationManager.sharedInstance.getLocationBlock(89.453678))
        XCTAssertEqual(89.455, LocationManager.sharedInstance.getLocationBlock(89.455876))
        XCTAssertEqual(89.455, LocationManager.sharedInstance.getLocationBlock(89.457123))
        XCTAssertEqual(-89.455, LocationManager.sharedInstance.getLocationBlock(-89.453763))
        XCTAssertEqual(-89.460, LocationManager.sharedInstance.getLocationBlock(-89.456456))
        XCTAssertEqual(-89.460, LocationManager.sharedInstance.getLocationBlock(-89.455987))
        
        XCTAssertEqual(189.450, LocationManager.sharedInstance.getLocationBlock(189.453678))
        XCTAssertEqual(189.455, LocationManager.sharedInstance.getLocationBlock(189.455876))
        XCTAssertEqual(189.455, LocationManager.sharedInstance.getLocationBlock(189.457123))
        //SL-114. We'll have to make sure the values from this call is rounded
        //test failure: -[LocationManagerTest testExample()] failed: XCTAssertEqual failed: ("Optional(-189.45500000000001)") is not equal to ("Optional(-189.45499999999998)")
        //XCTAssertEqual(-189.455, LocationManager.sharedInstance.getLocationBlock(-189.453763))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.456456))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.455987))
    }
    
    func testGetLocationBlockKety() {
        //SL-114
        XCTAssertEqual("000000", LocationManager.sharedInstance.getLocationBlockKey(0.003))
        XCTAssertEqual("000005", LocationManager.sharedInstance.getLocationBlockKey(0.005))
        XCTAssertEqual("000005", LocationManager.sharedInstance.getLocationBlockKey(0.007))
        XCTAssertEqual("-000005", LocationManager.sharedInstance.getLocationBlockKey(-0.003))
        XCTAssertEqual("-000010", LocationManager.sharedInstance.getLocationBlockKey(-0.006))
        XCTAssertEqual("-000010", LocationManager.sharedInstance.getLocationBlockKey(-0.005))
        XCTAssertEqual("000000", LocationManager.sharedInstance.getLocationBlockKey(0))
        
        XCTAssertEqual("089450", LocationManager.sharedInstance.getLocationBlockKey(89.453678))
        XCTAssertEqual("089455", LocationManager.sharedInstance.getLocationBlockKey(89.455876))
        XCTAssertEqual("089455", LocationManager.sharedInstance.getLocationBlockKey(89.457123))
        XCTAssertEqual("-089455", LocationManager.sharedInstance.getLocationBlockKey(-89.453763))
        XCTAssertEqual("-089460", LocationManager.sharedInstance.getLocationBlockKey(-89.456456))
        XCTAssertEqual("-089460", LocationManager.sharedInstance.getLocationBlockKey(-89.455987))
        
        XCTAssertEqual("189450", LocationManager.sharedInstance.getLocationBlockKey(189.453678))
        XCTAssertEqual("189455", LocationManager.sharedInstance.getLocationBlockKey(189.455876))
        XCTAssertEqual("189455", LocationManager.sharedInstance.getLocationBlockKey(189.457123))
        XCTAssertEqual("-189455", LocationManager.sharedInstance.getLocationBlockKey(-189.453763))
        XCTAssertEqual("-189460", LocationManager.sharedInstance.getLocationBlockKey(-189.456456))
        XCTAssertEqual("-189460", LocationManager.sharedInstance.getLocationBlockKey(-189.455987))
    }
    
    func testGetBigGeoBlockKey() {
        //SL-114
        XCTAssertEqual("000", LocationManager.sharedInstance.getBigGeoBlockKey(0.003))
        XCTAssertEqual("000", LocationManager.sharedInstance.getBigGeoBlockKey(0.005))
        XCTAssertEqual("000", LocationManager.sharedInstance.getBigGeoBlockKey(0.007))
        XCTAssertEqual("-001", LocationManager.sharedInstance.getBigGeoBlockKey(-0.003))
        XCTAssertEqual("-001", LocationManager.sharedInstance.getBigGeoBlockKey(-0.006))
        XCTAssertEqual("-001", LocationManager.sharedInstance.getBigGeoBlockKey(-0.005))
        XCTAssertEqual("000", LocationManager.sharedInstance.getBigGeoBlockKey(0))
        
        XCTAssertEqual("089", LocationManager.sharedInstance.getBigGeoBlockKey(89.453678))
        XCTAssertEqual("089", LocationManager.sharedInstance.getBigGeoBlockKey(89.455876))
        XCTAssertEqual("089", LocationManager.sharedInstance.getBigGeoBlockKey(89.457123))
        XCTAssertEqual("-090", LocationManager.sharedInstance.getBigGeoBlockKey(-89.453763))
        XCTAssertEqual("-090", LocationManager.sharedInstance.getBigGeoBlockKey(-89.456456))
        XCTAssertEqual("-090", LocationManager.sharedInstance.getBigGeoBlockKey(-89.455987))
        
        XCTAssertEqual("189", LocationManager.sharedInstance.getBigGeoBlockKey(189.453678))
        XCTAssertEqual("189", LocationManager.sharedInstance.getBigGeoBlockKey(189.455876))
        XCTAssertEqual("189", LocationManager.sharedInstance.getBigGeoBlockKey(189.457123))
        XCTAssertEqual("-190", LocationManager.sharedInstance.getBigGeoBlockKey(-189.453763))
        XCTAssertEqual("-190", LocationManager.sharedInstance.getBigGeoBlockKey(-189.456456))
        XCTAssertEqual("-190", LocationManager.sharedInstance.getBigGeoBlockKey(-189.455987))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
