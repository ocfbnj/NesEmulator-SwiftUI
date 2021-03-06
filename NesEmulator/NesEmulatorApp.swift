//
//  NesEmulatorApp.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/22.
//

import AVFoundation
import SwiftUI

@main
struct NesEmulatorApp: App {
    @StateObject private var dataController = DataController()
    private var audioSessionObserver: Any!

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }

    init() {
        audioSessionObserver = NotificationCenter.default.addObserver(
            forName: AVAudioSession.mediaServicesWereResetNotification,
            object: nil,
            queue: nil
        ) { [self] _ in
            self.setUpAudioSession()
        }

        // Configure the audio session initially.
        setUpAudioSession()
    }

    private func setUpAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .longFormAudio)
        } catch {
            print("Failed to set audio session route sharing policy: \(error)")
        }
    }
}
