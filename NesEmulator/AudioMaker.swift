//
//  AudioMaker.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/24.
//

import AVFoundation
import Combine
import Foundation

class AudioMaker {
    static let sampleRate = 44100

    private static let sampleCountPerFrame = sampleRate / GameView.frameRate
    private static let frameCount = AVAudioFrameCount(sampleCountPerFrame)
    private static let format = AVAudioFormat(standardFormatWithSampleRate: Double(sampleRate), channels: 1)!

    private let ae = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
    private var sampleCount = 0

    init() {
        buffer.frameLength = AudioMaker.frameCount

        ae.attach(player)
        ae.connect(player, to: ae.outputNode, format: AudioMaker.format)
        ae.prepare()
        try! ae.start()
    }

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }

    func stop() {
        sampleCount = 0
        player.stop()
    }

    func reset() {
        stop()
        play()
    }

    func pushSample(_ sample: Double) {
        buffer.floatChannelData?.pointee[sampleCount] = Float(sample * 0.5)
        sampleCount = (sampleCount + 1) % AudioMaker.sampleCountPerFrame

        if sampleCount == 0 {
            player.scheduleBuffer(buffer.copy() as! AVAudioPCMBuffer)
        }
    }
}
