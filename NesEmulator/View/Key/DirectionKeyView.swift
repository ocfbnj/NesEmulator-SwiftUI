//
//  DirectionKeyView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct DirectionKeyView: View {
    var bus = CBus(ptr: nil)

    var body: some View {
        VStack(spacing: 0) {
            KeyView(actions: (
                { () in press_button(self.bus, ButtonKey.up.joypadKey) },
                { () in release_button(self.bus, ButtonKey.up.joypadKey) }
            ))

            HStack(spacing: 30) {
                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.left.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.left.joypadKey) }
                ))

                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.right.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.right.joypadKey) }
                ))
            }

            KeyView(actions: (
                { () in press_button(self.bus, ButtonKey.down.joypadKey) },
                { () in release_button(self.bus, ButtonKey.down.joypadKey) }
            ))
        }
    }
}

struct DirectionKeyView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionKeyView()
    }
}
