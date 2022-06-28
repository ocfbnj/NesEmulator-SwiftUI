//
//  HomeView.swift
//  NesEmulator
//
//  Created by ocfbnj on 2022/6/23.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext)
    private var context: NSManagedObjectContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var roms: FetchedResults<Rom>

    var body: some View {
        NavigationView {
            List {
                ForEach(roms, id: \.self) { rom in
                    NavigationLink {
                        nextView(with: rom)
                    } label: {
                        Text("\(rom.name!)")
                    }
                }
                .onDelete(perform: deleteRom)
            }
            .navigationTitle("Games")
            .toolbar {
                HStack {
                    NavigationLink {
                        DocumentPicker(complete: { url in
                            let filename = url.lastPathComponent
                            let end = filename.index(filename.endIndex, offsetBy: -".nes".count)
                            let name = String(filename[..<end])

                            addRom(name: name, url: url)
                        })
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            if DataController.isFirstLaunch() {
                loadDefaultRom()
            }
        }
    }

    private func loadDefaultRom() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let defaultRom = [
            "Super Mario Bros",
            "Contra",
            "Duck Tales",
        ]

        for romName in defaultRom {
            let romUrl = url.appendingPathComponent("\(romName).nes")

            do {
                try NSDataAsset(name: romName)?.data.write(to: romUrl)
                addRom(name: romName, url: romUrl)
            } catch let err {
                print(err.localizedDescription)
            }
        }

        save()
    }

    private func addRom(name: String, url: URL) {
        let rom = Rom(context: context)
        rom.name = name
        rom.url = url

        save()
    }

    private func deleteRom(at indexSet: IndexSet) {
        for index in indexSet {
            let rom = roms[index]
            context.delete(rom)
        }

        save()
    }

    private func save() {
        do {
            try context.save()
        } catch let error {
            print("Failed to save rom: \(error.localizedDescription)")
        }
    }

    private func nextView(with rom: Rom) -> AnyView {
        do {
            let romData = try Data(contentsOf: rom.url!)
            return AnyView(GameView(name: rom.name!, romData: romData))
        } catch let err {
            return AnyView(Text("\(err.localizedDescription)").padding())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
