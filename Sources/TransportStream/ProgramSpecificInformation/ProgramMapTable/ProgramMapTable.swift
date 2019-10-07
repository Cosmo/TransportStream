//
//  ProgramMapTable.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation
import BinaryKit

struct ProgramMapTable: ProgramSpecificInformation {
    var tableId: UInt8
    var sectionSyntaxIndicator: Bool
    var zero: Bool
    var reserved: Int
    var sectionLength: Int
    var transportStreamId: Int
    var reserved2: Int
    var versionNumber: Int
    var currentNextIndicator: Bool
    var sectionNumber: UInt8
    var lastSectionNumber: UInt8
    
    var reserved3: Int
    var pcrProgramId: Int
    var reserved4: Int
    var programInfoLength: Int
    
    var descriptors: [Descriptor]
    var streams: [Stream]
    
    var crc: UInt32
    
    init(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        
        tableId = try binary.readByte()
        sectionSyntaxIndicator = try binary.readBool()
        zero = try binary.readBool()
        reserved = try binary.readBits(2)
        sectionLength = try binary.readBits(12)
        transportStreamId = try binary.readBits(16)
        reserved2 = try binary.readBits(2)
        versionNumber = try binary.readBits(5)
        currentNextIndicator = try binary.readBool()
        sectionNumber = try binary.readByte()
        lastSectionNumber = try binary.readByte()
        
        reserved3 = try binary.readBits(3)
        pcrProgramId = try binary.readBits(13)
        reserved4 = try binary.readBits(4)
        programInfoLength = try binary.readBits(12) >> 2
        
        let descriptorsBytes = try binary.readBytes(programInfoLength)
        descriptors = []
        
        let streamsLength = Self.dataLength(within: sectionLength) - programInfoLength
        let streamsBytes = try binary.readBytes(streamsLength)
        streams = []
        
        
        
        crc = try binary.readUInt32()
    }
}
