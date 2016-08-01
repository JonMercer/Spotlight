//
//  StringUtil.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation


extension String {
    static func locationToString(loc: String) -> String{
        return loc.stringByReplacingOccurrencesOfString(".", withString: "_")
    }
}