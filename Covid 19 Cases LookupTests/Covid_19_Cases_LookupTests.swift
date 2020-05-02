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
    
    private var countriesListViewModel: CountriesListViewModel!
    private var countryStatsViewModel: CountryStatsViewModel!
    private var testRepo: FakeRepository!

    override func setUp() {
        testRepo = FakeRepository()
        countriesListViewModel = CountriesListViewModel(repository: testRepo)
        countryStatsViewModel = CountryStatsViewModel(repository: testRepo)
    }

    func testOnAppearCountriesCallIsMadeAndStateIsLoading() {
        countriesListViewModel.onAppear()
        
        XCTAssertEqual(countriesListViewModel.state, LoadingState.loading)
        XCTAssertEqual(testRepo.loadCountriesCallCount, 1)
    }
    
    func testErrorIsDisplayedWhenNilIsReturnedFromRepo() {
        countriesListViewModel.onAppear()
        
        testRepo.returnCountries(valueToReturn: nil)
        
        XCTAssertEqual(countriesListViewModel.state, LoadingState.error)
    }
    
    func testListIsDisplayedWhenNilIsReturnedFromRepo() {
        let countries = [
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: "")
        ]
        countriesListViewModel.onAppear()
        
        testRepo.returnCountries(valueToReturn: countries)
        
        XCTAssertEqual(countriesListViewModel.state, LoadingState.success)
        XCTAssertEqual(countriesListViewModel.countries, countries)
    }
    
    func testOnRetryCountriesMakeACallToRepo() {
        countriesListViewModel.onAppear()
        
        countriesListViewModel.onRetry()
        
        XCTAssertEqual(countriesListViewModel.state, LoadingState.loading)
        XCTAssertEqual(testRepo.loadCountriesCallCount, 2)
    }
    
    
    func testStatsViewModelMakesARequestOnAppearWithTheRightCountry() {
        let country = Country(Country: "Ireland", Slug: "", ISO2: "")
        
        countryStatsViewModel.onAppear(country: country)
        
        XCTAssertEqual(testRepo.loadStatsCallCount, 1)
        XCTAssertEqual(testRepo.lastCountryToLoadStatsFor, country)
        XCTAssertEqual(countryStatsViewModel.state, LoadingState.loading)
    }
    
    func testStatsViewModelShowsErrorWhenGettingNilFromDataSource() {
        let country = Country(Country: "Ireland", Slug: "", ISO2: "")
        countryStatsViewModel.onAppear(country: country)
        
        testRepo.returnStatsForCountry(valueToReturn: nil)
        
        XCTAssertEqual(countryStatsViewModel.state, LoadingState.error)
    }
    
    func testStatsViewModelShowsResultsAfterLoadingSuccessfully() {
        let stats: [StatsForCountry] = [
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z")
        ]
        let country = Country(Country: "Ireland", Slug: "", ISO2: "")
        countryStatsViewModel.onAppear(country: country)
        
        testRepo.returnStatsForCountry(valueToReturn: stats)
        
        XCTAssertEqual(countryStatsViewModel.state, LoadingState.success)
        XCTAssertEqual(countryStatsViewModel.countryStats, stats)
    }
    
    func testOnRetryForStats() {
        let stats: [StatsForCountry] = [
            StatsForCountry(Confirmed: 90, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 105, Deaths: 1, Recovered: 50, Date: "2020-04-05T00:00:00Z")
        ]
        let country = Country(Country: "Ireland", Slug: "", ISO2: "")
        countryStatsViewModel.onAppear(country: country)
        testRepo.returnStatsForCountry(valueToReturn: nil)
        
        countryStatsViewModel.onRetry()
        testRepo.returnStatsForCountry(valueToReturn: stats)
        
        XCTAssertEqual(testRepo.loadStatsCallCount, 2)
        XCTAssertEqual(testRepo.lastCountryToLoadStatsFor, country)
        XCTAssertEqual(countryStatsViewModel.state, LoadingState.success)
    }
}

private class FakeRepository: CasesLookupRepository {
    private var callbackForCountries: (([Country]?) -> ())?
    private var callbackForStats: (([StatsForCountry]?) -> ())?
    var loadCountriesCallCount = 0
    var loadStatsCallCount = 0
    var lastCountryToLoadStatsFor: Country?
    
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        loadCountriesCallCount += 1
        callbackForCountries = completionCallback
    }
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        loadStatsCallCount += 1
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
