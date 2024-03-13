import SwiftUI

struct LearningSessionSettingsView: View {
    @ObservedObject var manager : DataManager
    
    @State private var numberOfCards = 10
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Number of Plants in Database: \(manager.plants.count)")
            
            Spacer()
            
            Text("Number of Cards to Review:")
            
            HStack {
                Spacer()
                TextField("Number of Cards", value: $numberOfCards, formatter: NumberFormatter())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Spacer()
            }
            
            Spacer()
            
            if numberOfCards > 0 {
                NavigationLink(destination: LearnView(manager: manager, numberOfCards: numberOfCards)) {
                    Text("Start Learning Session")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
            } else {
                Text("Start Learning Session")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Learning Session Settings")
    }
}

#Preview {
    LearningSessionSettingsView(manager: DataManager(preview: true))
}
