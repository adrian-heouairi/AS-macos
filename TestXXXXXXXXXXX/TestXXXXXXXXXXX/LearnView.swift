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

struct LearnView: View {
    @ObservedObject var manager : DataManager
    
    @State var numberOfCards : Int
    
    @State private var currentIndex = 0
    @State private var showAnswer = false
    @State private var plants: [Plant]
    
    init(manager: DataManager, numberOfCards: Int) {
        self.manager = manager
        self.numberOfCards = numberOfCards
        
        self.plants = chooseNRandomPlants(manager: manager, n: numberOfCards)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(currentIndex + 1) / \(plants.count)")
            
            if showAnswer {
                PlantDetailsView(plant: plants[currentIndex], showText: true)
            } else {
                PlantDetailsView(plant: plants[currentIndex], showText: false)
            }
            
            Button(action: {
                self.showAnswer.toggle()
            }) {
                Text(showAnswer ? "Hide Answer" : "Show Answer")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if showAnswer {
                Button(action: {
                    self.nextPlant()
                }) {
                    Text("Next")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            Spacer()
        }.onAppear {
            plants = chooseNRandomPlants(manager: manager, n: numberOfCards)
        }
    }
    
    func nextPlant() {
        currentIndex = (currentIndex + 1) % plants.count
        showAnswer = false
    }
}

#Preview {
    LearnView(manager: DataManager(preview: true), numberOfCards: 2)
}
