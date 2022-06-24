//
//  Game.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct Game: Hashable, Codable, Identifiable {
    var id: Int
    let name: String
    let data: Data
}

class Games: ObservableObject {
    @Published var data: [Game] = [
        Game(id: 0, name: "Super Mario Bro", data: NSDataAsset(name: "super_mario_bros")!.data),
        Game(id: 1, name: "Contra", data: NSDataAsset(name: "contra")!.data),
        Game(id: 2, name: "Duck Tales", data: NSDataAsset(name: "duck_tales")!.data),
        Game(id: 3, name: "Invalid", data: Data()),
    ]
}
