//
//  ControlKeyView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct ControlKeyView: View {
    var bus = CBus(ptr: nil)

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.b.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.b.joypadKey) }
                    ))
                    Text("B")
                }

                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.a.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.a.joypadKey) }
                    ))
                    Text("A")
                }
            }

            HStack {
                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.select.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.select.joypadKey) }
                    ))
                    Text("Sel")
                }

                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.start.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.start.joypadKey) }
                    ))
                    Text("Start")
                }
            }
        }
    }
}

struct ControlKeyView_Previews: PreviewProvider {
    static var previews: some View {
        ControlKeyView()
    }
}
