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
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.typeOfCases, label: Text("Type of Cases")) {
                Text("Confirmed").tag(0)
                Text("Deaths").tag(1)
                Text("Recovered").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            HStack {
                Picker(selection: $viewModel.monthNumber, label: Text("Month")) {
                    ForEach(self.viewModel.monthWithTagList, id: \.self) { title in
                        Text(title.month).tag(title.tag)
                    }
                }.pickerStyle(DefaultPickerStyle()).frame(maxWidth: 40, maxHeight: .infinity)
                GeometryReader { metrics in
                    ScrollView(.vertical) {
                        ForEach(self.viewModel.valuesToDisplay, id: \.self) { valueToDisplay in
                            BarView(barOutputStructure: valueToDisplay, widthOfBar: metrics.size.width).padding(.leading, 3).padding(.trailing, 3)
                        }
                        }.frame(maxWidth: .infinity).animation(.default)
                }
            }
        }.onDisappear { self.viewModel.onDisappear() }
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
