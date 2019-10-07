//
//  IPMPControlInformationTable.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation

struct IPMPControlInformationTable: ProgramSpecificInformation {
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
    
    
    
    var crc: UInt32
}
