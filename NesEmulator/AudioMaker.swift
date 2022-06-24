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
    static let sampleCountPerFrame = Int(Double(sampleRate) / GameView.frameRate)

    private static let frameCount = AVAudioFrameCount(AudioMaker.sampleCountPerFrame)
    private static let format = AVAudioFormat(standardFormatWithSampleRate: Double(AudioMaker.sampleRate), channels: 1)!

    var ae = AVAudioEngine()
    var player = AVAudioPlayerNode()
    var buffer = AVAudioPCMBuffer(pcmFormat: AudioMaker.format, frameCapacity: AudioMaker.frameCount)!
    var sampleCount = 0

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

    func stop() {
        sampleCount = 0
        player.stop()
    }

    func pause() {
        player.pause()
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
