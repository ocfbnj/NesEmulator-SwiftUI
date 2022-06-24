//
//  ButtonKey.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import Foundation

enum ButtonKey: UInt8 {
    case right = 0b10000000
    case left = 0b01000000
    case down = 0b00100000
    case up = 0b00010000
    case start = 0b00001000
    case select = 0b00000100
    case b = 0b00000010
    case a = 0b00000001

    var joypadKey: CJoypadButton {
        CJoypadButton(UInt32(rawValue))
    }
}
