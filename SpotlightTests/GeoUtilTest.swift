//
//  GeoUtilTest.swift
//  Spotlight
//
//  Created by Odin on 2016-07-24.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import XCTest
@testable import Spotlight


class GeoUtilTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalculateGeoRadius() {
        XCTAssertEqual(3, GeoUtil.calculateGeoRadius((0,0), b:(0,3)))
        XCTAssertEqual(0, GeoUtil.calculateGeoRadius((0,0), b:(0,0)))
        XCTAssertEqual(2, GeoUtil.calculateGeoRadius((-1,-1), b:(-3,-1)))
        XCTAssertEqual(3, GeoUtil.calculateGeoRadius((0,0), b:(0,-3)))
        XCTAssertEqual(3, GeoUtil.calculateGeoRadius((0,0), b:(-3,3)))
        XCTAssertEqual(4, GeoUtil.calculateGeoRadius((-1,-1), b:(-5,-5)))
        XCTAssertEqual(10, GeoUtil.calculateGeoRadius((10,5), b:(0,3)))
        XCTAssertEqual(360, GeoUtil.calculateGeoRadius((-180,0), b:(180,0)))
    }
    
    func testExtractGeoBlockKeyLatLon() {
        XCTAssertEqual(1, GeoUtil.extractGeoBlockKeyLatLon("1_1").0)
        XCTAssertEqual(1, GeoUtil.extractGeoBlockKeyLatLon("1_1").1)
        
        XCTAssertEqual(123, GeoUtil.extractGeoBlockKeyLatLon("123_123").0)
        XCTAssertEqual(123, GeoUtil.extractGeoBlockKeyLatLon("123_123").1)
        
        XCTAssertEqual(-167, GeoUtil.extractGeoBlockKeyLatLon("-167_167").0)
        XCTAssertEqual(167, GeoUtil.extractGeoBlockKeyLatLon("-167_167").1)
        
        XCTAssertEqual(0, GeoUtil.extractGeoBlockKeyLatLon("0_0").0)
        XCTAssertEqual(0, GeoUtil.extractGeoBlockKeyLatLon("0_0").1)
        
        XCTAssertEqual(-180, GeoUtil.extractGeoBlockKeyLatLon("-180_-180").0)
        XCTAssertEqual(-180, GeoUtil.extractGeoBlockKeyLatLon("-180_-180").1)
        
        XCTAssertEqual(-180, GeoUtil.extractGeoBlockKeyLatLon("-00180_-00180").0)
        XCTAssertEqual(-180, GeoUtil.extractGeoBlockKeyLatLon("-00180_-00180").1)
        
        XCTAssertEqual(123, GeoUtil.extractGeoBlockKeyLatLon("00123_00123").0)
        XCTAssertEqual(123, GeoUtil.extractGeoBlockKeyLatLon("00123_00123").1)
    }
    
    func testSortGeoBlocks() {
        self.sortGeoBlocks(["-1_-3", "1_2", "4_-5"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["1_2", "-1_-3", "4_-5"], sortedListOfGeoBlockKey)
        }
        
        self.sortGeoBlocks(["1_1", "0_1", "-1_-1", "1_-1"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["-1_-1", "0_1", "1_-1", "1_1"], sortedListOfGeoBlockKey)
        }
        
        self.sortGeoBlocks(["-1_-3", "1_2", "3_2"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["1_2", "-1_-3", "3_2"], sortedListOfGeoBlockKey)
        }
        
        self.sortGeoBlocks(["-001_-003", "001_002", "004_-005"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["001_002", "-001_-003", "004_-005"], sortedListOfGeoBlockKey)
        }
        
        self.sortGeoBlocks(["001_001", "000_001", "-001_-001", "001_-001"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["-001_-001", "000_001", "001_-001", "001_001"], sortedListOfGeoBlockKey)
        }
        
        self.sortGeoBlocks(["-001_-003", "001_002", "003_002"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
            XCTAssertEqual(["001_002", "-001_-003", "003_002"], sortedListOfGeoBlockKey)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension GeoUtilTest: BigGeoBlockEditor {
    
}
