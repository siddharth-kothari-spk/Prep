//
//  ColorProviding.swift
//  DI-Sample
//
//  Created by Siddharth Kothari on 13/07/23.
//

import Foundation
import UIKit

class ColorProviding: ColorProvider {
    var color: UIColor {
        let colors: [UIColor] = [.systemBlue, .systemGray, .systemRed]
        return colors.randomElement()!
    }
    
}
