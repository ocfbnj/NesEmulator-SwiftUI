//
//  Game.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct Game: Hashable, Codable, Identifiable {
    var id = UUID()
    let name: String
    let data: Data
}

class Games: ObservableObject {
    @Published var data: [Game] = [
        Game(name: "Super Mario Bro", data: NSDataAsset(name: "super_mario_bros")!.data),
        Game(name: "Contra", data: NSDataAsset(name: "contra")!.data),
        Game(name: "Duck Tales", data: NSDataAsset(name: "duck_tales")!.data),
        Game(name: "Invalid", data: Data()),
    ]
}
