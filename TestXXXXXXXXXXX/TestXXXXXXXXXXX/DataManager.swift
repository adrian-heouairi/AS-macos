import Foundation

func loadPreviewData() -> [Plant] {
    return [
        Plant(id: 110, filename: "110", commonName: "Wild yam", scientificName: "Dioscorea villosa", code: "DIVI4"),
        Plant(id: 113, filename: "113", commonName: "Thorny olive", scientificName: "Elaeagnus pungens", code: "ELPU2"),
        Plant(id: 120, filename: "120", commonName: "Dogwood", scientificName: "Cornus florida", code: "COFL2")
    ]
}

class DataManager: ObservableObject {
    @Published var plants : [Plant] = []

    init(preview: Bool) {
        if preview {
            plants = loadPreviewData()
        } else {
            plants = loadData("plants")
        }
    }
}

func loadData(_ filename: String) -> [Plant] {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
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
        return try decoder.decode([Plant].self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(Plant.self):\n\(error)")
    }
}
