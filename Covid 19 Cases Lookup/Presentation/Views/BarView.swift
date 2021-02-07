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
    var widthOfBar: CGFloat
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 40).foregroundColor(Color.black)
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green, getEndColorForValue()]), startPoint: .leading, endPoint: .trailing))
                .frame(width: barOutputStructure.normalizedValue * widthOfBar, height: 40).foregroundColor(Color.green)
            Text(String(barOutputStructure.actualValue)).foregroundColor(Color.white)
        }
    }
    
    private func getEndColorForValue() -> Color {
        if (barOutputStructure.normalizedValue > 0.75) {
            return Color.red
        } else if (barOutputStructure.normalizedValue > 0.5) {
            return Color.purple
        } else {
            return Color.blue
        }
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { metrics in
            VStack {
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.683, actualValue: 683), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 1, actualValue: 1000), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.828, actualValue: 828), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.670, actualValue: 670), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.6, actualValue: 600), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.5, actualValue: 500), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.2, actualValue: 200), widthOfBar: metrics
                .size.width)
                BarView(barOutputStructure:BarOutputStructure(normalizedValue: 0.05, actualValue: 50), widthOfBar: metrics
                .size.width)
            }
        }
    }
}
