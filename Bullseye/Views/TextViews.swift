//
//  TextViews.swift
//  Bullseye
//
//  Created by Виктория Виноградова on 06.10.2022.
//

import SwiftUI

struct InstructionText: View {

    let text: String

    var body: some View {
        Text(text.uppercased())
            .bold()
            .kerning(2.0)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .font(.footnote)
            .foregroundColor(Color("TextColor"))
    }
}

struct BigNumberText: View {

    let text: String

    var body: some View {
        Text(text)
            .kerning(-1.0)
            .fontWeight(.black)
            .font(.largeTitle)
            .foregroundColor(Color("TextColor"))
    }
}

struct LabelText: View {

    let text: String

    var body: some View {
        Text(text)
            .bold()
            .kerning(1.0)
            .font(.caption)
            .foregroundColor(Color("TextColor"))

    }
}

struct BodyText: View {

    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .lineSpacing(12)

    }
}

struct ButtonText: View {

    let text: String

    var body: some View {
        Text(text)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(
                Color.accentColor
            )
            .cornerRadius(12)

    }
}

struct ScoreText: View {

    let score: Int

    var body: some View {
        Text(String(score))
            .bold()
            .kerning(-0.2)
            .foregroundColor(Color("TextColor"))
            .font(.title3)
    }
}

struct DateText: View {

    let date: Date

    var body: some View {
        Text(date, style: .time)
            .bold()
            .kerning(-0.2)
            .foregroundColor(Color("TextColor"))
            .font(.title3)
    }
}

struct BigBoldText: View {

    let text: String

    var body: some View {
        Text(text.uppercased())
            .kerning(2.0)
            .font(.title)
            .fontWeight(.black)
            .foregroundColor(Color("TextColor"))
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InstructionText(text: "Instructions")
            BigNumberText(text: "999")
            LabelText(text: "23")
            BodyText(text: "You scored 73 points\n 🎉🎉🎉")
            ButtonText(text: "Start New Round")
                .padding()
            ScoreText(score: 10)
            DateText(date: Date())
            BigBoldText(text: "leaderboard")
        }
    }
}
