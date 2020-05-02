//
//  CountryStatsViewModel.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import SwiftUI

class CountryStatsViewModel: ObservableObject {
    
    init(repository: CasesLookupRepository) {
        repo = repository
    }
    
    @Published var countryStats: [StatsForCountry] = []
    @Published var state: LoadingState = LoadingState.loading
    
    private let repo: CasesLookupRepository
    private var country: Country!
    
    func onAppear(country: Country) {
        self.country = country
        loadCountryStats()
    }
    
    func onRetry() {
        loadCountryStats()
    }
    
    private func loadCountryStats() {
        repo.loadStatsForCountry(country: country, completionCallback: { countryStats in
            guard let finalCountryStats = countryStats else {
                self.state = LoadingState.error
                return
            }
            self.countryStats = finalCountryStats
            self.state = LoadingState.success
        })
    }
}
