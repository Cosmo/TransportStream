//
//  Demultiplexer.swift
//  Stream
//
//  Created by Devran on 04.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation
import BinaryKit

protocol PacketType { }

protocol DemultiplexerDelegate {
    func didParsePacket(packet: PartialTransportStreamPacket)
}

struct Demultiplexer {
    typealias PTSPacket = PartialTransportStreamPacket
    typealias PTSPacketError = PartialTransportStreamPacketError
    
    var delegate: DemultiplexerDelegate?
    
    var rawPackets: [Int: [PTSPacket]] = [:]
    var packetsInBytes: [Int: [UInt8]] = [:]
    var packets: [Int: [PacketType]] = [:]
    
    init() {
        
    }
    
    mutating func parse() {
        let url = Bundle.main.url(forResource: "alsobitlonger", withExtension: "ts")
        guard let dataUrl = url, let data = try? Data(contentsOf: dataUrl) else {
            print("Could not load file.")
            return
        }
        let bytes = [UInt8](data)
        var binary = Binary(bytes: bytes)
        
        print("Let's go.")
        
        do {
            while let subBytes = try? binary.readBytes(PTSPacket.length) {
                let packet = try PTSPacket(subBytes)
                append(packet: packet)
                delegate?.didParsePacket(packet: packet)
            }
        } catch PTSPacketError.syncLoss {
            print("TS: Out of sync.")
        } catch BinaryError.outOfBounds {
            print("BinaryError: Out of bounds.")
        } catch {
            print("Unexpected error: \(error)")
        }
        
        print("All done!")
    }
    
    mutating func append(packet: PTSPacket) {
        let pid = packet.packetIdentifier
        
        if packet.payloadUnitStartIndicator {
            processPreviousPackets(withPid: pid)
        }
        
        /// TODO: Add packets only if the continuity counter checks out
        rawPackets[pid, default: []].append(packet)
    }
    
    mutating func processPreviousPackets(withPid pid: Int) {
        guard let packetsOfPid = rawPackets[pid] else {
            // print("return")
            return
        }
        
        if !packetsOfPid.contains(where: { $0.payloadUnitStartIndicator }) {
            // print("This is gone! --> \(String(pid, radix: 16, uppercase: true))")
            // let lol = packetsOfPid.compactMap{ $0.payloadData }.joined().map{ String($0, radix: 16, uppercase: true) }
            rawPackets[pid] = []
            return
        }
        
        print("--------")
        print("\(packetsOfPid.count) packets in PID: \(pid)")
        
        defer {
            rawPackets[pid] = []
        }
        
        var bytes = [UInt8]()
        for packet in packetsOfPid {
            guard let payloadData = packet.payloadData else {
                return
            }
            
            bytes.append(contentsOf: payloadData)
        }
        
        packetsInBytes[pid, default: []].append(contentsOf: bytes)
    }
}
