//
//  File.swift
//  
//
//  Created by Devran on 16.08.19.
//

import Foundation
import BinaryKit

struct PartialTransportStreamPacket {
    typealias PTSPacketError = PartialTransportStreamPacketError
    static let length: Int = 188
    static let syncByte = 0x47
    
    var transportErrorIndicator: Bool
    var payloadUnitStartIndicator: Bool
    var transportPriority: Bool
    var packetIdentifier: Int
    var transportScramblingControl: Int
    var adaptationFieldControl: AdaptationFieldControl
    var continuityCounter: UInt8
    
    // Optional fields
    var adaptationField: AdaptationField?
    var payloadData: [UInt8]?
    
    init(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        
        if try binary.readByte() != Self.syncByte {
            throw PTSPacketError.syncLoss
        }
        
        transportErrorIndicator = try binary.readBool()
        payloadUnitStartIndicator = try binary.readBool()
        transportPriority = try binary.readBool()
        packetIdentifier = try binary.readBits(13)
        transportScramblingControl = try binary.readBits(2)
        adaptationFieldControl = AdaptationFieldControl(try binary.readBits(2))
        continuityCounter = try binary.readNibble()
        
        if adaptationFieldControl.hasAdaptationField {
            let adaptationFieldControlLength = try binary.readByte()
            let adaptationFieldControlBytes = try binary.readBytes(adaptationFieldControlLength)
            adaptationField = try AdaptationField(adaptationFieldControlBytes)
        }
        
        if adaptationFieldControl.hasPayload {
            let remainingBytesCount = binary.remainingBytesCount()
            payloadData = try binary.readBytes(remainingBytesCount)
        }
    }
}

