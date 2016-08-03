//
//  LocationTest.swift
//  Spotlight
//
//  Created by Odin on 2016-08-02.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import XCTest
@testable import Spotlight

class LocationTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetGeoBlock() {
        XCTAssertEqual(0, Location.sharedInstance.getGeoBlock(0.0))
        XCTAssertEqual(400, Location.sharedInstance.getGeoBlock(0.4))
        XCTAssertEqual(-400, Location.sharedInstance.getGeoBlock(-0.4))
        
        XCTAssertEqual(0, Location.sharedInstance.getGeoBlock(0.004))
        XCTAssertEqual(5, Location.sharedInstance.getGeoBlock(0.005))
        XCTAssertEqual(5, Location.sharedInstance.getGeoBlock(0.0051))
        
        XCTAssertEqual(-5, Location.sharedInstance.getGeoBlock(-0.004))
        XCTAssertEqual(-5, Location.sharedInstance.getGeoBlock(-0.005))
        XCTAssertEqual(-10, Location.sharedInstance.getGeoBlock(-0.0051))
        
        XCTAssertEqual(-1000, Location.sharedInstance.getGeoBlock(-0.999))
        
        XCTAssertEqual(-1005, Location.sharedInstance.getGeoBlock(-1.004))
        XCTAssertEqual(-1005, Location.sharedInstance.getGeoBlock(-1.005))
        XCTAssertEqual(-1010, Location.sharedInstance.getGeoBlock(-1.0051))
        
        XCTAssertEqual(-111005, Location.sharedInstance.getGeoBlock(-111.004))
        XCTAssertEqual(-111005, Location.sharedInstance.getGeoBlock(-111.005))
        XCTAssertEqual(-111010, Location.sharedInstance.getGeoBlock(-111.0051))
    
    }

    func testPerformanceExample() {
        self.measureBlock {
        }
    }

}
