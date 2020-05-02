//
//  LocalRepository.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

class LocalRepository: CasesLookupRepository {
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        completionCallback([
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: ""),
            Country(Country: "UK", Slug: "", ISO2: "")
        ])
    }
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        
    }
}
