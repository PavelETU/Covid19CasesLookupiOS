//
//  CasesLookupViewModel.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 30/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import SwiftUI

class CasesLookupViewModel: ObservableObject {
    
    init(repository: CasesLookupRepository) {
        repo = repository
    }
    
    @Published var countries: [Country] = []
    @Published var state: LoadingState = LoadingState.loading
    private let repo: CasesLookupRepository
    
    func onAppear() {
        repo.loadCountries(completionCallback: { countries in
            guard let countriesToDisplay = countries else {
                self.state = LoadingState.error
                return
            }
            self.state = LoadingState.success
            self.countries = countriesToDisplay
        })
    }
}

enum LoadingState {
    case loading
    case success
    case error
}
