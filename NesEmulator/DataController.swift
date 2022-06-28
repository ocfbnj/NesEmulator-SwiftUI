//
//  DataController.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/28.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    static func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let key = "First Launch"

        defer {
            defaults.set(true, forKey: key)
        }

        return defaults.bool(forKey: key) == false
    }
}
