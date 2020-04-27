//
//  CasesLookupPresenterImpl.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import os

class CasesLookupPresenterImpl: CasesLookupPresenter {
    init(repository: CasesLookupRepository, view: CasesLookupView) {
        self.view = view
        self.repository = repository
        self.repository.loadCountries(completionCallback: self.handle(countries:))
    }
    
    private weak var view: CasesLookupView!
    private let repository: CasesLookupRepository
    
    private func handle(countries: [Country]?) {
        guard let countriesToDisplay = countries else {
            return
        }
        view?.displayCountries(countries: countriesToDisplay)
    }
}
