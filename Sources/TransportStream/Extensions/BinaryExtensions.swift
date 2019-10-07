//
//  BinaryExtensions.swift
//  
//
//  Created by Devran on 07.10.19.
//

import Foundation
import BinaryKit

public extension Binary {
    func remainingBytesCount() -> Int {
        let cursorPosition = readBitCursor / 8
        return bytesStore.count - cursorPosition
    }
    
    mutating func byteWithCursor() throws -> UInt8 {
        return try getBit(index: readBitCursor)
    }
    
    mutating func byteWithCursor(skippingBytes quantitiy: Int) throws -> UInt8 {
        return try getBit(index: readBitCursor + (quantitiy * UInt8.bitWidth))
    }
}
