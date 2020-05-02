//
//  Covid_19_Cases_LookupTests.swift
//  Covid 19 Cases LookupTests
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import XCTest
@testable import Covid_19_Cases_Lookup

class Covid_19_Cases_LookupTests: XCTestCase {
    
    var viewModel: CountriesListViewModel!
    var testRepo: FakeRepository!

    override func setUp() {
        testRepo = FakeRepository()
        viewModel = CountriesListViewModel(repository: testRepo)
    }

    func testOnAppearCountriesCallIsMadeAndStateIsLoading() {
        viewModel.onAppear()
        
        XCTAssertEqual(viewModel.state, LoadingState.loading)
        XCTAssertEqual(testRepo.loadCountriesCallCount, 1)
    }
    
    func testErrorIsDisplayedWhenNilIsReturnedFromRepo() {
        viewModel.onAppear()
        
        testRepo.returnCountries(valueToReturn: nil)
        
        XCTAssertEqual(viewModel.state, LoadingState.error)
    }
    
    func testListIsDisplayedWhenNilIsReturnedFromRepo() {
        let countries = [
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: "")
        ]
        viewModel.onAppear()
        
        testRepo.returnCountries(valueToReturn: countries)
        
        XCTAssertEqual(viewModel.state, LoadingState.success)
        XCTAssertEqual(viewModel.countries, countries)
    }
    
    func testOnRetryCountriesMakeACallToRepo() {
        viewModel.onAppear()
        
        viewModel.onRetry()
        
        XCTAssertEqual(viewModel.state, LoadingState.loading)
        XCTAssertEqual(testRepo.loadCountriesCallCount, 2)
    }
}

class FakeRepository: CasesLookupRepository {
    var callbackForCountries: (([Country]?) -> ())?
    var callbackForStats: (([StatsForCountry]?) -> ())?
    var loadCountriesCallCount = 0
    var loadStatsCallCount = 0
    var lastCountryToLoadStatsFor: Country?
    
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        loadCountriesCallCount += 1
        callbackForCountries = completionCallback
    }
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        lastCountryToLoadStatsFor = country
        callbackForStats = completionCallback
    }
    
    func returnCountries(valueToReturn: [Country]?) {
        callbackForCountries?(valueToReturn)
    }
    
    func returnStatsForCountry(valueToReturn: [StatsForCountry]?) {
        callbackForStats?(valueToReturn)
    }
}
