//
//  HomeView+ViewModel.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/28.
//

import Foundation

extension HomeView {
    enum PopList: CaseIterable {
        case loadDefault
        case addRom
    }

    @MainActor class ViewModel: ObservableObject {
        @Published var isPresented = false
    }
}

extension HomeView.PopList {
    var description: String {
        switch self {
        case .loadDefault: return "Load default roms"
        case .addRom: return "Add rom"
        }
    }
}
