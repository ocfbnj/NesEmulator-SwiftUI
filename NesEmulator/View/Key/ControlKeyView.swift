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
                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.a.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.a.joypadKey) }
                ))

                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.b.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.b.joypadKey) }
                ))
            }

            HStack {
                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.select.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.select.joypadKey) }
                ))

                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.start.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.start.joypadKey) }
                ))
            }
        }
    }
}

struct ControlKeyView_Previews: PreviewProvider {
    static var previews: some View {
        ControlKeyView()
    }
}
