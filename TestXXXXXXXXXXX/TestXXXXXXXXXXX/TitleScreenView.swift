import SwiftUI

struct TitleScreenView: View {
    @ObservedObject var manager : DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("The Plant Review")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: DataListView(manager: manager)) {
                    Text("Learn")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: DataListView(manager: manager)) {
                    Text("List of plants")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    TitleScreenView(manager: DataManager(preview: true))
}
