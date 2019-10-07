//
//  AdaptationFieldControl.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation

public struct AdaptationFieldControl {
    private let adaptationValue = 0b10
    private let payloadValue = 0b01
    
    public var hasAdaptationField: Bool
    public var hasPayload: Bool
    
    public init(_ flags: Int) {
        // Bits     Value
        // 00       Reserved
        // 01       Payload only
        // 10       Adaptation field only
        // 11       Adaptation field and payload
        
        hasAdaptationField = flags & adaptationValue == 1
        hasPayload = flags & payloadValue == 1
    }
}
