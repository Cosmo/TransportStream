//
//  ProgramSpecificInformation.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation

protocol ProgramSpecificInformation {
    var tableId: UInt8 { get }
    var sectionSyntaxIndicator: Bool { get }
    var zero: Bool { get }
    var reserved: Int { get }
    var sectionLength: Int { get }
    var transportStreamId: Int { get }
    var reserved2: Int { get }
    var versionNumber: Int { get }
    var currentNextIndicator: Bool { get }
    var sectionNumber: UInt8 { get }
    var lastSectionNumber: UInt8 { get }
    
    var crc: UInt32 { get }
}

extension ProgramSpecificInformation {
    /// Returns the number of bytes of PSI-data based on the `sectionLength`.
    static func dataLength(within sectionLength: Int) -> Int {
        // Number of bytes from `sectionLength` to `lastSectionNumber`
        let ignoreableHeaderLength = 5
        // Number of bytes of CRC
        let crcBytesLength = CyclicRedundancyCheck.bitLength / UInt8.bitWidth
        
        let bytesToIgnore = ignoreableHeaderLength + crcBytesLength
        return sectionLength - bytesToIgnore
    }
}


/*
struct Table {
    
}

struct ProgramSpecificInformation {
    var pointerField: UInt8
    var pointerFillerBytes: [UInt8]
    
    var tables: [Table]
    
    init(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        
        pointerField = try binary.readByte()
        pointerFillerBytes = try binary.readBytes(pointerField)
        tables = []
        
        let tableId = try binary.readByte()
        let sectionSyntaxIndicator = try binary.readBit()
        let privateBit = try binary.readBit()
        let reservedBits = try binary.readBits(2)
        let sectionLengthUnusedBits = try binary.readBits(2)
        let sectionLength = try binary.readBits(10)
        let tableData = try binary.readBytes(sectionLength)
        
        
    }
}
*/
