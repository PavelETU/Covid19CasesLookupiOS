//
//  CasesLookupViewModel.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 30/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import SwiftUI

class CountriesListViewModel: ObservableObject {
    
    init(repository: CasesLookupRepository) {
        repo = repository
    }
    
    @Published var countries: [Country] = []
    @Published var state: LoadingState = LoadingState.loading
    
    private let repo: CasesLookupRepository
    
    func onAppear() {
        repo.loadCountries(completionCallback: { countries in
            self.handleResults(countries: countries)
        })
    }
    
    func onRetry() {
        repo.loadCountries(completionCallback: { countries in
            self.handleResults(countries: countries)
        })
    }
    
    private func handleResults(countries: [Country]?) {
        guard let countriesToDisplay = countries else {
            self.state = LoadingState.error
            return
        }
        self.countries = countriesToDisplay
        self.state = LoadingState.success
    }
}

enum LoadingState {
    case loading
    case success
    case error
}
