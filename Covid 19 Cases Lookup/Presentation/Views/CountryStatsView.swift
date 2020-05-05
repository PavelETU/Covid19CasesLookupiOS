//
//  CountryStatsView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct CountryStatsView: View {
    @ObservedObject var statsPresentationViewModel = StatsPresentationViewModel()
    var countryStats: [StatsForCountry]
    
    var body: some View {
        GeometryReader { metrics in
            HStack(alignment: .center, spacing: BarConstants.SPACING_BTW_BARS) {
                ForEach(self.statsPresentationViewModel.valuesToDisplay, id: \.self) { valueToDisplay in
                    BarView(barOutputStructure: valueToDisplay)
                }
            }.onAppear { self.statsPresentationViewModel.onAppear(countryStats: self.countryStats, screenWidth: metrics.size.width) }
        }
    }
}

struct CountryStatsView_Previews: PreviewProvider {
    static var previews: some View {
    CountryStatsView(countryStats: [
            StatsForCountry(Confirmed: 300, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 180, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 200, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 250, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 300, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 150, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 5, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 10, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 5, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 300, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z")
        ])
    }
}
