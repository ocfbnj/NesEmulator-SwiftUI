//
//  FunctionalKeyView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/24.
//

import SwiftUI

struct FunctionalKeyView: View {
    var bus = CBus(ptr: nil)

    var body: some View {
        HStack {
            ZStack {
                KeyView(actions: (
                    { () in },
                    { () in quick_save(bus) }
                ))
                Text("S")
            }

            ZStack {
                KeyView(actions: (
                    { () in },
                    { () in quick_restore(bus) }
                ))
                Text("R")
            }
        }
    }
}

struct FunctionalKeyView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionalKeyView()
    }
}
