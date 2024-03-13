import SwiftUI

struct PlantDetailsView: View {
    let plant: Plant
    
    let showText: Bool

    var body: some View {
        VStack {
            Image(plant.filename)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
                .padding()
            
            if showText {
                Text("Common Name: \(plant.commonName)")
                Text("Scientific Name: \(plant.scientificName)")
                Text("Code: \(plant.code)")
            }
            
            Spacer()
        }
        .navigationTitle("Plant Details")
    }
}

#Preview {
    PlantDetailsView(plant: Plant(id: 113, filename: "113", commonName: "Thorny olive", scientificName: "Elaeagnus pungens", code: "ELPU2"), showText: true)
}
