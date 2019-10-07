//
//  File.swift
//  
//
//  Created by Devran on 16.08.19.
//

import Foundation
import BinaryKit

struct AdaptationExtension {
    var legalTimeWindowFlag: Bool
    var piecewiseRateFlag: Bool
    var seamlessSpliceFlag: Bool
    var reserved: Int
    
    // Optional fields
    // LTW flag set (2 bytes)
    var legalTimeWindowValidFlag: Bool?
    var legalTimeWindowOffset: Int?
    
    // Piecewise flag set (3 bytes)
    var piecewiseReserved: Int?
    var piecewiseRate: Int?
    
    // Seamless splice flag set (5 bytes)
    var spliceType: Int?
    var dtsNextAccessUnit: Int?
    
    init?(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        legalTimeWindowFlag = try binary.readBool()
        piecewiseRateFlag = try binary.readBool()
        seamlessSpliceFlag = try binary.readBool()
        reserved = try binary.readBits(5)
        
        if legalTimeWindowFlag {
            legalTimeWindowValidFlag = try binary.readBool()
            legalTimeWindowOffset = try binary.readBits(15)
        }
        
        if piecewiseRateFlag {
            piecewiseReserved = try binary.readBits(2)
            piecewiseRate = try binary.readBits(22)
        }
        
        if seamlessSpliceFlag {
            spliceType = try binary.readBits(4)
            dtsNextAccessUnit = try binary.readBits(36)
        }
    }
}
