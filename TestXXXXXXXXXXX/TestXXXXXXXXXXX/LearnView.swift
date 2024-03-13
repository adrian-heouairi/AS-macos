import SwiftUI

struct LearnView: View {
    @State private var currentIndex = 0
    @State private var showAnswer = false
    let plants: [Plant]
    
    var body: some View {
        VStack {
            if showAnswer {
                PlantDetailsView(plant: plants[currentIndex])
            } else {
                Image(plants[currentIndex].filename)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Button(action: {
                self.showAnswer.toggle()
            }) {
                Text(showAnswer ? "Hide Answer" : "Show Answer")
            }
            .padding()
            
            if showAnswer {
                Button(action: {
                    self.nextPlant()
                }) {
                    Text("Next")
                }
                .padding()
            }
            
            Spacer()
        }
    }
    
    func nextPlant() {
        currentIndex = (currentIndex + 1) % plants.count
        showAnswer = false
    }
}
