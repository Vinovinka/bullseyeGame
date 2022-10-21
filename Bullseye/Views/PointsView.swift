//
//  PointsView.swift
//  Bullseye
//
//  Created by Виктория Виноградова on 08.10.2022.
//

import SwiftUI

struct PointsView: View {

    @Binding var isAlertVisible: Bool
    @Binding var sliderValue: Double
    @Binding var game: Game

    var body: some View {

        let roundedValue = Int(sliderValue.rounded())
        let points = game.points(sliderValue: roundedValue)

        VStack(spacing: 10) {
            InstructionText(text: "The slider's value is")
            BigNumberText(text: String(roundedValue))
                .accessibilityIdentifier("sliderValue")
            BodyText(text: "You scored \(points) Points\n 🎉🎉🎉")
                .accessibilityIdentifier("yourScoreLabel")

            Button (action: {
                withAnimation {
                    isAlertVisible = false
                }
                game.startNewRound(points: points)

            }){
                ButtonText(text: "Start New Round")
            }
            .accessibilityIdentifier("startNewRowndButton")
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color("BackgroundColor"))
        .cornerRadius(Constants.General.roundRectCornerRadius)
        .shadow(radius: 10, x: 5, y: 5)
        .transition(.scale)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("alertView")
    }
}

struct PointsView_Previews: PreviewProvider {


    static var previews: some View {
        PointsView(isAlertVisible: .constant(true), sliderValue: .constant(50.0), game: .constant(Game()))
    }
}
