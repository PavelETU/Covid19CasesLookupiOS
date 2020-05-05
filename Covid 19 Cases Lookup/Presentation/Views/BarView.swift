//
//  BarView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 04/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI


struct BarView: View {
    var barOutputStructure: BarOutputStructure
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: barOutputStructure.barWidth, height: BarConstants.MAX_VALUE_OF_BAR)   .foregroundColor(Color.black)
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [getEndColorForValue(), Color.green]), startPoint: .top, endPoint: .bottom))
                .frame(width: barOutputStructure.barWidth, height: barOutputStructure.normalizedValue).foregroundColor(Color.green)
            Text(String(barOutputStructure.actualValue)).foregroundColor(Color.white)
        }
    }
    
    private func getEndColorForValue() -> Color {
        if (barOutputStructure.normalizedValue > BarConstants.MAX_VALUE_OF_BAR / 1.5) {
            return Color.red
        } else if (barOutputStructure.normalizedValue > BarConstants.MAX_VALUE_OF_BAR / 2) {
            return Color.purple
        } else {
            return Color.blue
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(barOutputStructure:BarOutputStructure(barWidth: 40, normalizedValue: 250, actualValue: 250))
    }
}
