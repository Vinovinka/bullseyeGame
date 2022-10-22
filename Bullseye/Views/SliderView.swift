//
//  SliderLabelTextView.swift
//  Bullseye
//
//  Created by Виктория Виноградова on 06.10.2022.
//

import SwiftUI

struct SliderView: View {

    @Binding var sliderValue: Double
    
    var body: some View {
        HStack {
            SliderLabelText(text: "1")

            Slider(value: $sliderValue, in: 1.0...100.0)
                .accessibilityIdentifier("slider")

            SliderLabelText(text: "100")
        }
    }
}

struct SliderLabelText: View {

    var text: String

    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(Color("TextColor"))
            .frame(width: 35)
    }
}


struct SliderLabelTextView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(sliderValue: .constant(25.0))
    }
}
