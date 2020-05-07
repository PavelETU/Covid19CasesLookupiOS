//
//  LocalRepository.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

class LocalRepository: CasesLookupRepository {
    let irelandStats = [
        StatsForCountry(Confirmed: 20, Deaths: 3, Recovered: 105, Date: "2020-02-04T00:00:00Z"),
        StatsForCountry(Confirmed: 45, Deaths: 0, Recovered: 20, Date: "2020-03-04T00:00:00Z"),
        StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
        StatsForCountry(Confirmed: 105, Deaths: 3, Recovered: 50, Date: "2020-04-05T00:00:00Z")
    ]
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        completionCallback([
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: ""),
            Country(Country: "UK", Slug: "", ISO2: "")
        ])
    }
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        if (country.Country == "Ireland") {
            completionCallback(irelandStats)
        } else {
            completionCallback([])
        }
    }
}
