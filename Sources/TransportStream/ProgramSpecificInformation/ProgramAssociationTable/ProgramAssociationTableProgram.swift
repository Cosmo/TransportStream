//
//  ProgramAssociationTableProgram.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation
import BinaryKit

public struct ProgramAssociationTableProgram {
    public static let byteLength = 4
    
    public enum PacketIdentifierType {
        case network
        case programMap
    }
    
    public var programNumber: UInt16
    public var reserved: Int
    public var packetIdentifierType: PacketIdentifierType
    public var packetIdentifier: Int
    
    public init(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        programNumber = try binary.readUInt16()
        reserved = try binary.readBits(3)
        packetIdentifier = try binary.readBits(13)
        
        if programNumber == 0 {
            packetIdentifierType = .network
        } else {
            packetIdentifierType = .programMap
        }
    }
    
    static func programs(bytes: [UInt8]) throws -> [Self] {
        return try bytes.chunked(byteLength).map {
            return try Self($0)
        }
    }
}
