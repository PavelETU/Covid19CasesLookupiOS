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
    
    var viewModel: CasesLookupViewModel!
    var testRepo: FakeRepository!

    override func setUp() {
        testRepo = FakeRepository()
        viewModel = CasesLookupViewModel(repository: testRepo)
    }

    func testOnAppearCountriesCallIsMadeAndStateIsLoading() {
        viewModel.onAppear()
        
        XCTAssertEqual(viewModel.state, LoadingState.loading)
        XCTAssertEqual(testRepo.loadCountriesCallCount, 1)
    }
    
    func testErrorIsDisplayedWhenNilIsReturnedFromRepo() {
        viewModel.onAppear()
        
        testRepo.returnValue(valueToReturn: nil)
        
        XCTAssertEqual(viewModel.state, LoadingState.error)
    }
    
    func testListIsDisplayedWhenNilIsReturnedFromRepo() {
        let countries = [
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: "")
        ]
        viewModel.onAppear()
        
        testRepo.returnValue(valueToReturn: countries)
        
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
    var callback: (([Country]?) -> ())?
    var loadCountriesCallCount = 0
    
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        loadCountriesCallCount += 1
        callback = completionCallback
    }
    
    func returnValue(valueToReturn: [Country]?) {
        callback?(valueToReturn)
    }
}
