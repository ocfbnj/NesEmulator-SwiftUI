//
//  GameView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

import Combine
import SwiftUI

struct GameView: View {
    static let frameRate = 60.0

    let romData = NSDataAsset(name: "super_mario_bros")!.data

    @State var cancel: AnyCancellable?
    @State var bus = CBus(ptr: nil)
    @StateObject var frame = Frame()

    var body: some View {
        HStack {
            VStack {
                Spacer()
                DirectionKeyView(bus: self.bus)
            }

            Spacer()

            NesView(frameData: self.frame)
                .aspectRatio(Frame.ratio, contentMode: .fit)
                .ignoresSafeArea()
                .onAppear {
                    if !loadRom(romData) {
                        fatalError("load rom failed")
                    }

                    runNesCore()
                }
                .onDisappear {
                    cancel?.cancel()
                    free_bus(self.bus)
                }

            Spacer()

            VStack {
                Spacer()
                ControlKeyView(bus: self.bus)
            }
        }
    }

    func loadRom(_ data: Data) -> Bool {
        data.withUnsafeBytes { bufferPtr in
            loadFromRawBufferPointer(bufferPtr: bufferPtr)
        }
    }

    private func loadFromRawBufferPointer(bufferPtr: UnsafeRawBufferPointer) -> Bool {
        let ptr = bufferPtr.baseAddress!
        let len = bufferPtr.count

        let cartridge = load_cartridge(ptr, Int32(len))
        if cartridge.ptr == nil {
            return false
        }

        bus = alloc_bus()
        insert_cartridge(bus, cartridge)
        power_up(bus)

        return true
    }

    private func runNesCore() {
        cancel = Timer.publish(every: 1.0 / GameView.frameRate, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                let cframe = perform_once(self.bus)
                self.frame.update(cframe)
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
