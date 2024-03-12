import SwiftUI

struct PlantDetailsView: View {
    let plant: Plant

    var body: some View {
        VStack {
            Image(plant.filename)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
                .padding()
            
            Text("Common Name: \(plant.commonName)")
                .font(.headline)
                .padding()
            
            Text("Scientific Name: \(plant.scientificName)")
                .font(.headline)
                .padding()
            
            Text("Code: \(plant.code)")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Plant Details")
    }
}

#Preview {
    PlantDetailsView(plant: Plant(id: 113, filename: "113", commonName: "Thorny olive", scientificName: "Elaeagnus pungens", code: "ELPU2"))
}
