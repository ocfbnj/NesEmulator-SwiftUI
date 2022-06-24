//
//  KeyView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import SwiftUI

struct KeyView: View {
    typealias Action = () -> Void

    static let size = 60.0
    var actions: (Action, Action)?

    var body: some View {
        Button {
            // do nothing
        } label: {
            Circle()
                .frame(width: KeyView.size, height: KeyView.size)
                .foregroundColor(.gray)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.actions?.0()
                })
                .onEnded({ _ in
                    self.actions?.1()
                })
        )
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
