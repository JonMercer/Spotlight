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
        //test failure: -[LocationManagerTest testExample()] failed: XCTAssertEqual failed: ("Optional(-189.45500000000001)") is not equal to ("Optional(-189.45499999999998)")
        //XCTAssertEqual(-189.455, LocationManager.sharedInstance.getLocationBlock(-189.453763))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.456456))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.455987))
    }
    
    func testGetLocationBlockKety() {
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
        XCTAssertEqual(-189.455, LocationManager.sharedInstance.getLocationBlock(-189.453763))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.456456))
        XCTAssertEqual(-189.460, LocationManager.sharedInstance.getLocationBlock(-189.455987))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
