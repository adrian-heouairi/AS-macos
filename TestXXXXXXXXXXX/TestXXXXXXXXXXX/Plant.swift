import Foundation

// [ ..., { "id": 107, "filename": "107.jpg", "common_name": "Autumn olive", "scientific_name": "Eleaegnus umbellata", "code": "ELUM" }, ... ]

struct Plant : Hashable, Codable, Identifiable {
    var id: Int
    var filename: String
    var commonName: String
    var scientificName: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case filename
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case code
    }
}
