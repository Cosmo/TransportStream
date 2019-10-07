//
//  File.swift
//  
//
//  Created by Devran on 16.08.19.
//

import Foundation
import BinaryKit

struct AdaptationField {
    var discontinuityIndicator: Bool
    var randomAccessIndicator: Bool
    var elementaryStreamPriorityIndicator: Bool
    var programClockReferenceFlag: Bool
    var originalProgramClockReferenceFlag: Bool
    var splicingPointFlag: Bool
    var transportPrivateDataFlag: Bool
    var adaptationFieldExtensionFlag: Bool
    
    // Optional fields
    var programClockReference: [UInt8]?
    var originalProgramClockReference: [UInt8]?
    var spliceCountdown: Int?
    var transportPrivateDataLength: Int?
    var transportPrivateData: [UInt8]?
    var adaptationExtension: AdaptationExtension?
    var stuffingBytes: [UInt8]?
    
    init?(_ bytes: [UInt8]) throws {
        var binary = Binary(bytes: bytes)
        
        discontinuityIndicator = try binary.readBool()
        randomAccessIndicator = try binary.readBool()
        elementaryStreamPriorityIndicator = try binary.readBool()
        programClockReferenceFlag = try binary.readBool()
        originalProgramClockReferenceFlag = try binary.readBool()
        splicingPointFlag = try binary.readBool()
        transportPrivateDataFlag = try binary.readBool()
        adaptationFieldExtensionFlag = try binary.readBool()
        
        if programClockReferenceFlag {
            programClockReference = try binary.readBytes(6)
        }
        
        if originalProgramClockReferenceFlag {
            originalProgramClockReference = try binary.readBytes(6)
        }
        
        if splicingPointFlag {
            spliceCountdown = try binary.readBits(8)
        }
        
        if transportPrivateDataFlag {
            let transportPrivateDataLength = try binary.readBits(8)
            transportPrivateData = try binary.readBytes(transportPrivateDataLength)
        }
        
        if adaptationFieldExtensionFlag {
            let adaptationExtensionLength = try binary.readByte()
            let bytes = try binary.readBytes(adaptationExtensionLength)
            adaptationExtension = try AdaptationExtension(bytes)
        }
    }
}
