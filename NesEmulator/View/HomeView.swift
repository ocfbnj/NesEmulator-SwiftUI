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

    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            Group {
                List {
                    ForEach(roms, id: \.self) { rom in
                        NavigationLink {
                            nextView(with: rom)
                        } label: {
                            Text("\(rom.name!)")
                        }
                    }
                    .onDelete(perform: deleteRom)

                    if roms.isEmpty {
                        HStack {
                            Spacer()

                            VStack {
                                Text("There are no roms")
                                    .font(.title2)

                                Button("Load default roms") {
                                    loadDefaultRom()
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding()

                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Games")
            .toolbar {
                Menu {
                    Button("\(PopList.loadDefault.description)") {
                        loadDefaultRom()
                    }

                    Button("\(PopList.addRom.description)") {
                        viewModel.isPresented.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $viewModel.isPresented) {
                    DocumentPicker(complete: { url in
                        let filename = url.lastPathComponent
                        let end = filename.index(filename.endIndex, offsetBy: -".nes".count)
                        let name = String(filename[..<end])

                        addRom(name: name, url: url)
                    })
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
        let fm = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let resourceUrl = Bundle.main.resourceURL!
        let items = try! fm.contentsOfDirectory(atPath: resourcePath)

        for rom in items.filter({ $0.hasSuffix(".nes") }) {
            let romName = String(rom.dropLast(".nes".count))
            let romUrl = resourceUrl.appendingPathComponent(rom)

            addRom(name: romName, url: romUrl)
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
