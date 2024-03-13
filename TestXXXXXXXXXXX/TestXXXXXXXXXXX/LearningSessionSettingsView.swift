import SwiftUI

// Chooses at most n plants at random
func chooseNRandomPlants(manager: DataManager, n: Int) -> [Plant] {
    if n <= 0 {
        return []
    }
    
    let shuffledPlants = manager.plants.shuffled()
    
    if n >= shuffledPlants.count {
        return shuffledPlants
    } else {
        return Array(shuffledPlants.prefix(n))
    }
}

struct LearningSessionSettingsView: View {
    @ObservedObject var manager : DataManager
    
    @State private var numberOfCards = 10
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Number of Plants in Database: \(manager.plants.count)")
            
            Spacer()
            
            Text("Number of Cards to Review:")
            
            TextField("Number of Cards", value: $numberOfCards, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Spacer()
            
            if numberOfCards > 0 {
                NavigationLink(destination: LearnView(plants: chooseNRandomPlants(manager: manager, n: numberOfCards))) {
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
