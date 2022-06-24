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
            ZStack {
                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.up.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.up.joypadKey) }
                ))
                Text("Up")
            }

            HStack(spacing: 30) {
                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.left.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.left.joypadKey) }
                    ))
                    Text("Left")
                }

                ZStack {
                    KeyView(actions: (
                        { () in press_button(self.bus, ButtonKey.right.joypadKey) },
                        { () in release_button(self.bus, ButtonKey.right.joypadKey) }
                    ))
                    Text("Right")
                }
            }

            ZStack {
                KeyView(actions: (
                    { () in press_button(self.bus, ButtonKey.down.joypadKey) },
                    { () in release_button(self.bus, ButtonKey.down.joypadKey) }
                ))
                Text("Down")
            }
        }
    }
}

struct DirectionKeyView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionKeyView()
    }
}
