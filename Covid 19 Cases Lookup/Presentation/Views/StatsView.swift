//
//  StatsView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 07/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var viewModel: CountryStatsViewModel
    @State var monthNumber = 0
    
    var body: some View {
        VStack {
            Picker(selection: self.$viewModel.typeOfCases, label: Text("Type of Cases")) {
                Text("Confirmed").tag(0)
                Text("Deaths").tag(1)
                Text("Recovered").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
                .padding(5)
            ScrollView(.horizontal) {
            Picker(selection: $monthNumber, label: Text("Month")) {
                    Text("January").tag(0)
                    Text("Febuary").tag(1)
                    Text("March").tag(2)
                    Text("April").tag(3)
                    Text("May").tag(4)
                    Text("June").tag(5)
                    Text("July").tag(6)
                    Text("August").tag(7)
                    Text("September").tag(8)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 20)
            
            }
            HStack(alignment: .center, spacing: BarConstants.SPACING_BTW_BARS) {
                ForEach(self.viewModel.valuesToDisplay, id: \.self) { valueToDisplay in
                    BarView(barOutputStructure: valueToDisplay)
                }
            }.animation(.default)
        }
    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .darkGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView().environmentObject(CountryStatsViewModel(repository: LocalRepository()))
    }
}
