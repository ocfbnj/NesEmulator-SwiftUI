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
    private static let audioMaker = AudioMaker()

    var name = "Super Mario Bros"
    var romData = NSDataAsset(name: "super_mario_bros")!.data

    @State var bus = CBus(ptr: nil)
    @State var invalid = false
    @State var cancel: AnyCancellable?
    @StateObject var frame = Frame()

    var body: some View {
        Group {
            if !invalid {
                ZStack {
                    VStack {
                        NesView(frameData: self.frame)
                            .aspectRatio(Frame.ratio, contentMode: .fit)
                        Spacer()
                    }

                    VStack {
                        Spacer()

                        HStack {
                            ZStack {
                                KeyView(actions: (
                                    { () in },
                                    { () in
                                        quick_reset(bus)
                                        GameView.audioMaker.reset()
                                    }
                                ))
                                Text("Reset")
                            }

                            Spacer()

                            FunctionalKeyView(bus: self.bus)
                        }
                        .padding()

                        HStack {
                            DirectionKeyView(bus: self.bus)
                            Spacer()
                            ControlKeyView(bus: self.bus)
                        }
                        .padding()
                    }
                    .opacity(0.6)
                }
            } else {
                Text("Unsupported NES ROM")
                    .font(.title)
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            invalid = !loadRom(romData)
            if invalid {
                return
            }

            GameView.audioMaker.play()
            runNesCore()
        }
        .onDisappear {
            GameView.audioMaker.stop()
            cancel?.cancel()
            free_bus(self.bus)
            clear_shared_data()
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
        set_sample_rate(bus, Int32(AudioMaker.sampleRate))
        set_sample_cb(bus, { sample in
            GameView.audioMaker.pushSample(sample)
        })
        power_up(bus)

        return true
    }

    private func runNesCore() {
        cancel = Timer.publish(every: 1.0 / GameView.frameRate, on: .main, in: .default)
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
    }
}
