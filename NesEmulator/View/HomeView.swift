//
//  HomeView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var games = Games()

    var body: some View {
        NavigationView {
            List(games.data) { game in
                NavigationLink {
                    GameView(name: game.name, romData: game.data)
                } label: {
                    Text("\(game.name)")
                }
            }
            .navigationTitle("Games")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
