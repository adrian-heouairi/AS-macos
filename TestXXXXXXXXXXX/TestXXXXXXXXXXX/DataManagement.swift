//
//  File.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import Foundation

func loadPreviewData() -> [DataItem] {
    return [ DataItem(id: 0, name: "Hi", isTagged: true),
             DataItem(id: 1, name: "Hu", isTagged: false),
             DataItem(id: 2, name: "Ho", isTagged: true),
    ]
}

class DataManager: ObservableObject {
    @Published var items : [DataItem] = []
    private var state : Bool = true
    private var id = 0
    init(_ state: Bool) {
        self.state = state
        if self.state {
            items = loadData("Data.json")
        } else {
            items = loadPreviewData()
        }
    }
    func add() {
        id += 1
        items.append(DataItem(id: id, name: "Hi", isTagged: true))
        print("one more")
    }
    func load() {
        /*
        if self.state {
            items = loadData("Data.json")
        }
         */
    }
}

func loadData(_ filename: String) -> [DataItem] {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode([DataItem].self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(DataItem.self):\n\(error)")
    }
}
