//
//  Stream.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation
import BinaryKit

struct Stream {
    var streamType: UInt8
    var reserved: Int
    var elementaryProgramId: Int
    var reserved2: Int
    var elementaryStreamInfoLength: Int
    var descriptors: [Descriptor]
    
    init(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        
        streamType = try binary.readByte()
        reserved = try binary.readBits(3)
        elementaryProgramId = try binary.readBits(13)
        reserved2 = try binary.readBits(4)
        
        // Ignore the first two bits of `elementaryStreamInfoLength`
        elementaryStreamInfoLength = try binary.readBits(10) >> 2
        
        let descriptorsBytes = try binary.readBytes(elementaryStreamInfoLength)
        descriptors = []
    }
}
