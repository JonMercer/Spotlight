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
        
        XCTAssertEqual(0, Location.sharedInstance.getGeoBlock(0.000999))
        XCTAssertEqual(-5, Location.sharedInstance.getGeoBlock(-0.000999))
        
        XCTAssertEqual(0, Location.sharedInstance.getGeoBlock(0.003))
        XCTAssertEqual(5, Location.sharedInstance.getGeoBlock(0.005))
        XCTAssertEqual(5, Location.sharedInstance.getGeoBlock(0.007))
        XCTAssertEqual(-5, Location.sharedInstance.getGeoBlock(-0.003))
        XCTAssertEqual(-10, Location.sharedInstance.getGeoBlock(-0.006))
        XCTAssertEqual(-5, Location.sharedInstance.getGeoBlock(-0.005))
        XCTAssertEqual(-10, Location.sharedInstance.getGeoBlock(-0.005002))
        XCTAssertEqual(0, Location.sharedInstance.getGeoBlock(0.0))
        
        XCTAssertEqual(89450, Location.sharedInstance.getGeoBlock(89.453678))
        XCTAssertEqual(89455, Location.sharedInstance.getGeoBlock(89.455876))
        XCTAssertEqual(89455, Location.sharedInstance.getGeoBlock(89.457123))
        XCTAssertEqual(-89455, Location.sharedInstance.getGeoBlock(-89.453763))
        XCTAssertEqual(-89460, Location.sharedInstance.getGeoBlock(-89.456456))
        XCTAssertEqual(-89460, Location.sharedInstance.getGeoBlock(-89.455987))
        
        XCTAssertEqual(189450, Location.sharedInstance.getGeoBlock(189.453678))
        XCTAssertEqual(189455, Location.sharedInstance.getGeoBlock(189.455876))
        XCTAssertEqual(189455, Location.sharedInstance.getGeoBlock(189.457123))
        XCTAssertEqual(-189455, Location.sharedInstance.getGeoBlock(-189.453763))
        XCTAssertEqual(-189460, Location.sharedInstance.getGeoBlock(-189.456456))
        XCTAssertEqual(-189460, Location.sharedInstance.getGeoBlock(-189.455987))

        XCTAssertEqual(-1000, Location.sharedInstance.getGeoBlock(-1.000))
        XCTAssertEqual(-1005, Location.sharedInstance.getGeoBlock(-1.0001))
    
    }
    
    func testGetGeoBlockKey() {
        XCTAssertEqual("000000_000000", Location.sharedInstance.getGeoBlockKey(0.0, lon: 0.0))
        XCTAssertEqual("001000_001000", Location.sharedInstance.getGeoBlockKey(1.0, lon: 1.0))
        XCTAssertEqual("-001000_-001000", Location.sharedInstance.getGeoBlockKey(-1.0, lon: -1.0))
        
        XCTAssertEqual("000005_-000005", Location.sharedInstance.getGeoBlockKey(0.005, lon: -0.005))
        XCTAssertEqual("000005_-000010", Location.sharedInstance.getGeoBlockKey(0.005123, lon: -0.005123))
        XCTAssertEqual("000005_-000010", Location.sharedInstance.getGeoBlockKey(0.005999, lon: -0.005999))
        XCTAssertEqual("000000_-000005", Location.sharedInstance.getGeoBlockKey(0.000999, lon: -0.000999))
        
        XCTAssertEqual("000000_000005", Location.sharedInstance.getGeoBlockKey(0.003, lon: 0.005))
        XCTAssertEqual("000005_-000005", Location.sharedInstance.getGeoBlockKey(0.007, lon: -0.003))
        XCTAssertEqual("-000010_-000005", Location.sharedInstance.getGeoBlockKey(-0.006, lon: -0.005))
        XCTAssertEqual("-000010_-000010", Location.sharedInstance.getGeoBlockKey(-0.006, lon: -0.00502))
        
        XCTAssertEqual("089450_089455", Location.sharedInstance.getGeoBlockKey(89.453678, lon: 89.455876))
        XCTAssertEqual("089455_-089455", Location.sharedInstance.getGeoBlockKey(89.457123, lon: -89.453763))
        XCTAssertEqual("-089460_-089460", Location.sharedInstance.getGeoBlockKey(-89.456456, lon:-89.455987))
        
        XCTAssertEqual("189450_189455", Location.sharedInstance.getGeoBlockKey(189.453678, lon: 189.455876))
        XCTAssertEqual("189455_-189455", Location.sharedInstance.getGeoBlockKey(189.457123, lon: -189.453763))
        XCTAssertEqual("-189460_-189460", Location.sharedInstance.getGeoBlockKey(-189.456456, lon: -189.455987))
    }
    
    func testGetBigGeoBlockKey() {
        XCTAssertEqual("000_000", Location.sharedInstance.getBigGeoBlockKey(0.0, lon: 0.0))
        
        XCTAssertEqual("000_000", Location.sharedInstance.getBigGeoBlockKey(0.003, lon: 0.005))
        XCTAssertEqual("000_-001", Location.sharedInstance.getBigGeoBlockKey(0.007, lon: -0.003))
        XCTAssertEqual("-001_-001", Location.sharedInstance.getBigGeoBlockKey(-0.006, lon: -0.005))
        
        XCTAssertEqual("089_089", Location.sharedInstance.getBigGeoBlockKey(89.453678, lon: 89.455876))
        XCTAssertEqual("089_-090", Location.sharedInstance.getBigGeoBlockKey(89.457123, lon: -89.453763))
        XCTAssertEqual("-090_-090", Location.sharedInstance.getBigGeoBlockKey(-89.456456, lon: -89.455987))
        
        XCTAssertEqual("189_189", Location.sharedInstance.getBigGeoBlockKey(189.453678, lon: 189.455876))
        XCTAssertEqual("189_-190", Location.sharedInstance.getBigGeoBlockKey(189.457123, lon: -189.453763))
        XCTAssertEqual("-190_-190", Location.sharedInstance.getBigGeoBlockKey(-189.456456, lon: -189.455987))
    }

    func testPerformanceExample() {
        self.measureBlock {
        }
    }

}
