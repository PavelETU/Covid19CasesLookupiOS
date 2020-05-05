//
//  BarView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 04/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

let MAX_VALUE_OF_BAR: CGFloat = 300

struct BarView: View {
    var barWidth: CGFloat
    var value: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: barWidth, height: MAX_VALUE_OF_BAR)   .foregroundColor(Color.black)
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [getEndColorForValue(), Color.green]), startPoint: .top, endPoint: .bottom))
                .frame(width: barWidth, height: value).foregroundColor(Color.green)
            Text(String(format: "%.0f", Double(value))).foregroundColor(Color.white)
        }
    }
    
    private func getEndColorForValue() -> Color {
        if (value > MAX_VALUE_OF_BAR / 1.5) {
            return Color.red
        } else if (value > MAX_VALUE_OF_BAR / 2) {
            return Color.purple
        } else {
            return Color.blue
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(barWidth: 40, value: 250)
    }
}
