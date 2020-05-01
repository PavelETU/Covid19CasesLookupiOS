//
//  LoadingView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 01/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI


struct LoadingView: View {
    
    @State var degrees = 0.0
    @State var color: Color = Color.green
    
    @State var red: Double = 0
    @State var green: Double = 1
    @State var blue: Double = 0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.75)
            .stroke(color, lineWidth: 20)
            .frame(width: 200, height: 200)
            .rotationEffect(Angle(degrees: degrees))
            .onAppear(perform: {self.startProgress()})
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    func startProgress() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            withAnimation {
                self.degrees += 10
                if (self.degrees.truncatingRemainder(dividingBy: 40) == 0) {
                    self.color = Color.init(red: self.red, green: self.green, blue: self.blue)
                    self.red += Double.random(in: 0..<0.3)
                    self.green += Double.random(in: 0..<0.3)
                    self.blue += Double.random(in: 0..<0.3)
                }
            }
            if (self.degrees == 360) {
                self.degrees = 0
            }
            if (self.red > 0.9) {
                self.red = 0
            }
            if (self.green > 0.9) {
                self.green = 0
            }
            if (self.blue > 0.9) {
                self.blue = 0
            }
        })
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
