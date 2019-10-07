//
//  ProgramAssociationTable.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation
import BinaryKit

struct ProgramAssociationTable: ProgramSpecificInformation {
    typealias PATProgram = ProgramAssociationTableProgram
    
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
    
    var programs: [PATProgram]
    
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
        
        let programLength = Self.dataLength(within: sectionLength)
        let programBytes  = try binary.readBytes(programLength)
        programs = try PATProgram.programs(bytes: programBytes)
        
        crc = try binary.readUInt32()
    }
}
