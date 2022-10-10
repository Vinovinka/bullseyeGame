//
//  HitMeButtonView.swift
//  Bullseye
//
//  Created by Виктория Виноградова on 06.10.2022.
//

import SwiftUI

struct HitMeButtonView: View {
    @Binding var game: Game

    @Binding var sliderValue: Double

    @Binding var isAlertVisible: Bool

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isAlertVisible = true
                }
            }) {
                Text("Hit me".uppercased())
                    .bold()
                    .font(.title3)
            }
            .padding(15.0)
            .background(
                ZStack {
                    Color("ButtonColor")
                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                }
            )
            .foregroundColor(.white)
            .cornerRadius(15.0)
            .overlay(
                RoundedRectangle(cornerRadius: 15.0)
                    .strokeBorder(Color.white, lineWidth: Constants.General.strokeWidth)
            )

        }
    }
}

struct HitMeButtonView_Previews: PreviewProvider {

    static var previews: some View {
        HitMeButtonView(game: .constant(Game()), sliderValue: .constant(30.0), isAlertVisible: .constant(false))
    }
}
