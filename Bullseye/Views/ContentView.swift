import SwiftUI

struct ContentView: View {

    @State private var isAlertVisible = false

    @State private var sliderValue = 50.0

    @State private var game = Game()

    var body: some View {
        ZStack {
            BackgroundView(game: $game)
            
            VStack {
                InstructionView(game: $game)
                    .padding(.bottom, isAlertVisible ? 0 : 100)

                if isAlertVisible {
                    PointsView(isAlertVisible: $isAlertVisible, sliderValue: $sliderValue, game: $game)
                        .transition(.scale)
                } else {
                    HitMeButtonView(game: $game, sliderValue: $sliderValue, isAlertVisible: $isAlertVisible)
                        .transition(.scale)
                }
            }

            if !isAlertVisible {
                SliderView(sliderValue: $sliderValue)
                    .transition(.scale)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("backgroundView")
    }
}

struct InstructionView: View {

    @Binding var game: Game

    var body: some View {
        VStack {
            InstructionText(text: "🎯🎯🎯 \nPut the bullseye as close as you can to ")
                .padding(.leading, 30.0)
                .padding(.trailing, 30.0)

            BigNumberText(text: String(game.target))
                .accessibilityIdentifier("requestedNumberValue")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
