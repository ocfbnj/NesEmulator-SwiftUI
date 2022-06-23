//
//  Frame.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

import Foundation
import SwiftUI

final class Frame: ObservableObject {
    static let width = 256
    static let height = 240
    static let ratio = 256.0 / 240.0

    @Published var cframe = CFrame(data: nil)

    func update(_ cframe: CFrame) {
        self.cframe.data = cframe.data
    }
}
