//
//  CGPoint+distanceTo.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/25.
//

import CoreGraphics

extension CGPoint {
    func distanceTo(_ other: CGPoint) -> CGFloat {
        sqrt((x - other.x) * (x - other.x) + (y - other.y) * (y - other.y))
    }
}
