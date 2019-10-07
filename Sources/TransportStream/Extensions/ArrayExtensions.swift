//
//  ArrayExtensions.swift
//  Stream
//
//  Created by Devran on 06.10.19.
//  Copyright © 2019 Devran. All rights reserved.
//

import Foundation

internal extension Array {
    func chunked(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
