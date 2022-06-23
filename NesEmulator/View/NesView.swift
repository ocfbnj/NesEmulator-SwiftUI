//
//  NesView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

import MetalKit
import SwiftUI

struct NesView: UIViewRepresentable {
    @StateObject var frameData = Frame()

    func makeCoordinator() -> Renderer {
        Renderer(self)
    }

    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = Int(GameView.frameRate)
        mtkView.enableSetNeedsDisplay = true

        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }

        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size

        return mtkView
    }

    func updateUIView(_ uiView: MTKView, context: Context) {
        uiView.draw()
    }
}

struct NesView_Previews: PreviewProvider {
    static var previews: some View {
        NesView()
            .aspectRatio(Frame.ratio, contentMode: .fit)
    }
}
