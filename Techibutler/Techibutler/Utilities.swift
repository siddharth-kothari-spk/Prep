//
//  Utilities.swift
//  Techibutler
//
//  Created by Siddharth Kothari on 26/04/24.
//

import Foundation

class Utilities {
    
    static func performHeavyComputation() {
        DispatchQueue.global(qos: .background).async {
            let startTime = CFAbsoluteTimeGetCurrent()
            for _ in 1...2_000_000 {
                
            }
            let endTime = CFAbsoluteTimeGetCurrent()
            let elapsedTime = endTime - startTime
            print("Heavy computation took \(elapsedTime) seconds")
        }
    }
}
