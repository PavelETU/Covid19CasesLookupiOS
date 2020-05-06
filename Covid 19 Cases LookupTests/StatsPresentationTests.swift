//
//  StatsPresentationTests.swift
//  Covid 19 Cases LookupTests
//
//  Created by Pavel Suvit on 05/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import XCTest
@testable import Covid_19_Cases_Lookup

class StatsPresentationTests: XCTestCase {
    
    private var viewModel: CountryStatsViewModel!
    
    override func setUp() {
        viewModel = CountryStatsViewModel(repository: FakeRepo())
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""), screenWidth: 180)
    }
    
    func testArraySplitIntoMonthsProperly() {
        XCTAssertEqual(viewModel.confirmedCasesByMonth[0].count, 2)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[1].count, 1)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[2].count, 1)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3].count, 5)
        XCTAssertEqual(viewModel.confirmedCasesByMonth.count, 4)
        
        XCTAssertEqual(viewModel.deathsByMonth[0].count, 2)
        XCTAssertEqual(viewModel.deathsByMonth[1].count, 1)
        XCTAssertEqual(viewModel.deathsByMonth[2].count, 1)
        XCTAssertEqual(viewModel.deathsByMonth[3].count, 5)
        XCTAssertEqual(viewModel.deathsByMonth.count, 4)
        
        XCTAssertEqual(viewModel.recoveredByMonth[0].count, 2)
        XCTAssertEqual(viewModel.recoveredByMonth[1].count, 1)
        XCTAssertEqual(viewModel.recoveredByMonth[2].count, 1)
        XCTAssertEqual(viewModel.recoveredByMonth[3].count, 5)
        XCTAssertEqual(viewModel.recoveredByMonth.count, 4)
    }
    
    func testConfirmedCasesParsedProperly() {
        XCTAssertEqual(viewModel.confirmedCasesByMonth[0][0], 200)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[0][1], 300)
        
        XCTAssertEqual(viewModel.confirmedCasesByMonth[1][0], 400)
        
        XCTAssertEqual(viewModel.confirmedCasesByMonth[2][0], 600)
        
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3][0], 30000)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3][1], 33000)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3][2], 36000)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3][3], 38000)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[3][4], 39000)
    }

    func testDeathsCasesParsedProperly() {
        XCTAssertEqual(viewModel.deathsByMonth[0][0], 1)
        XCTAssertEqual(viewModel.deathsByMonth[0][1], 5)
        
        XCTAssertEqual(viewModel.deathsByMonth[1][0], 6)
        
        XCTAssertEqual(viewModel.deathsByMonth[2][0], 10)
        
        XCTAssertEqual(viewModel.deathsByMonth[3][0], 150)
        XCTAssertEqual(viewModel.deathsByMonth[3][1], 150)
        XCTAssertEqual(viewModel.deathsByMonth[3][2], 160)
        XCTAssertEqual(viewModel.deathsByMonth[3][3], 150)
        XCTAssertEqual(viewModel.deathsByMonth[3][4], 200)
    }
    
    func testRecoveredCasesParsedProperly() {
        XCTAssertEqual(viewModel.recoveredByMonth[0][0], 40)
        XCTAssertEqual(viewModel.recoveredByMonth[0][1], 50)
        
        XCTAssertEqual(viewModel.recoveredByMonth[1][0], 60)
        
        XCTAssertEqual(viewModel.recoveredByMonth[2][0], 80)
        
        XCTAssertEqual(viewModel.recoveredByMonth[3][0], 20000)
        XCTAssertEqual(viewModel.recoveredByMonth[3][1], 21000)
        XCTAssertEqual(viewModel.recoveredByMonth[3][2], 22000)
        XCTAssertEqual(viewModel.recoveredByMonth[3][3], 23000)
        XCTAssertEqual(viewModel.recoveredByMonth[3][4], 24000)
    }
}

private class FakeRepo: CasesLookupRepository {
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        
    }
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        completionCallback([
            StatsForCountry(Confirmed: 200, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 300, Deaths: 5, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
            StatsForCountry(Confirmed: 400, Deaths: 6, Recovered: 60, Date: "2020-05-04T00:00:00Z"),
            StatsForCountry(Confirmed: 600, Deaths: 10, Recovered: 80, Date: "2020-06-05T00:00:00Z"),
            StatsForCountry(Confirmed: 30000, Deaths: 150, Recovered: 20000, Date: "2020-11-04T00:00:00Z"),
            StatsForCountry(Confirmed: 33000, Deaths: 150, Recovered: 21000, Date: "2020-11-07T00:00:00Z"),
            StatsForCountry(Confirmed: 36000, Deaths: 160, Recovered: 22000, Date: "2020-11-08T00:00:00Z"),
            StatsForCountry(Confirmed: 38000, Deaths: 150, Recovered: 23000, Date: "2020-11-14T00:00:00Z"),
            StatsForCountry(Confirmed: 39000, Deaths: 200, Recovered: 24000, Date: "2020-11-20T00:00:00Z")
        ])
    }
    
    
}
