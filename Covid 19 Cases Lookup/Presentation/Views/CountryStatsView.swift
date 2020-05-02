//
//  CountryStatsView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct CountryStatsView: View {
    var countryStats: [StatsForCountry]
    var body: some View {
        let statsToDisplay = countryStats.last
        var stringToDisplay = ""
        if (statsToDisplay != nil) {
            stringToDisplay = "There are " + String(statsToDisplay!.Confirmed) + " confirmed cases as of " + (statsToDisplay!.Date)
        }
        return Text(stringToDisplay)
    }
}

struct CountryStatsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatsView(countryStats: [
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z")
        ])
    }
}
