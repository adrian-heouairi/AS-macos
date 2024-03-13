import SwiftUI

struct DataListView: View {
    @ObservedObject var manager : DataManager
    
    var items : [Plant] {
        manager.plants
    }
    
    var body: some View {
            List {
                ForEach(items) {
                    d in
                    NavigationLink {
                        PlantDetailsView(plant: d, showText: true)
                    } label: {
                        HStack {
                            Image(d.filename).resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                            Text("\(d.commonName) (\(d.scientificName))")
                        }
                    }
                }
            }
    }
    
}

#Preview {
    DataListView(manager: DataManager(preview: true))
}
