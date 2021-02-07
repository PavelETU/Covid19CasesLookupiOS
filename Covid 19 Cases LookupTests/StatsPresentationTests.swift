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
    private var testRepo: TestRepository!
    
    override func setUp() {
        testRepo = TestRepository()
        viewModel = CountryStatsViewModel(repository: testRepo)
    }
    
    func testArraySplitIntoMonthsProperly() {
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats()
        
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
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats()
        
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
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats()
        
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
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats()
        
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
    
    func testEmptyStatsAreDisplayedProperly() {
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats(stats: [
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-04-04T00:00:00Z")
        ])
        
        XCTAssertEqual(viewModel.confirmedCasesByMonth[0].count, 1)
        XCTAssertEqual(viewModel.confirmedCasesByMonth.count, 1)
        XCTAssertEqual(viewModel.confirmedCasesByMonth[0][0], 0)
        
        XCTAssertEqual(viewModel.deathsByMonth[0].count, 1)
        XCTAssertEqual(viewModel.deathsByMonth.count, 1)
        XCTAssertEqual(viewModel.deathsByMonth[0][0], 0)
        
        XCTAssertEqual(viewModel.recoveredByMonth[0].count, 1)
        XCTAssertEqual(viewModel.recoveredByMonth.count, 1)
        XCTAssertEqual(viewModel.recoveredByMonth[0][0], 0)
        
        XCTAssertEqual(viewModel.valuesToDisplay.count, 1)
        XCTAssertEqual(viewModel.valuesToDisplay[0].normalizedValue, 0)
        XCTAssertEqual(viewModel.valuesToDisplay[0].actualValue, 0)
    }
    
    func testMonthTitlesAreDisplayedProperly() {
        viewModel.onAppear(country: Country(Country: "", Slug: "", ISO2: ""))
        testRepo.returnStats(stats: [
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-01-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-02-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-03-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-04-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-05-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-06-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-07-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-08-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-09-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-10-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-11-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-12-04T00:00:00Z"),
            StatsForCountry(Confirmed: 0, Deaths: 0, Recovered: 0, Date: "2020-03-04T00:00:00Z")
        ])
        
        XCTAssertEqual(viewModel.monthWithTagList.count, 13)
        XCTAssertEqual(viewModel.monthWithTagList[0].month, "Jan")
        XCTAssertEqual(viewModel.monthWithTagList[1].month, "Feb")
        XCTAssertEqual(viewModel.monthWithTagList[2].month, "Mar")
        XCTAssertEqual(viewModel.monthWithTagList[3].month, "Apr")
        XCTAssertEqual(viewModel.monthWithTagList[4].month, "May")
        XCTAssertEqual(viewModel.monthWithTagList[5].month, "Jun")
        XCTAssertEqual(viewModel.monthWithTagList[6].month, "Jul")
        XCTAssertEqual(viewModel.monthWithTagList[7].month, "Aug")
        XCTAssertEqual(viewModel.monthWithTagList[8].month, "Sep")
        XCTAssertEqual(viewModel.monthWithTagList[9].month, "Oct")
        XCTAssertEqual(viewModel.monthWithTagList[10].month, "Nov")
        XCTAssertEqual(viewModel.monthWithTagList[11].month, "Dec")
        XCTAssertEqual(viewModel.monthWithTagList[12].month, "Mar")
        
        XCTAssertEqual(viewModel.monthWithTagList[0].tag, 0)
        XCTAssertEqual(viewModel.monthWithTagList[1].tag, 1)
        XCTAssertEqual(viewModel.monthWithTagList[2].tag, 2)
        XCTAssertEqual(viewModel.monthWithTagList[3].tag, 3)
        XCTAssertEqual(viewModel.monthWithTagList[4].tag, 4)
        XCTAssertEqual(viewModel.monthWithTagList[5].tag, 5)
        XCTAssertEqual(viewModel.monthWithTagList[6].tag, 6)
        XCTAssertEqual(viewModel.monthWithTagList[7].tag, 7)
        XCTAssertEqual(viewModel.monthWithTagList[8].tag, 8)
        XCTAssertEqual(viewModel.monthWithTagList[9].tag, 9)
        XCTAssertEqual(viewModel.monthWithTagList[10].tag, 10)
        XCTAssertEqual(viewModel.monthWithTagList[11].tag, 11)
        XCTAssertEqual(viewModel.monthWithTagList[12].tag, 12)
    }
}

private class TestRepository: CasesLookupRepository {
    
    private var statsCallback: (([StatsForCountry]?) -> ())?
    
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {}
    
    func loadStatsForCountry(country: Country, completionCallback: @escaping ([StatsForCountry]?) -> ()) {
        statsCallback = completionCallback
    }
    
    func returnStats(stats: [StatsForCountry]? = [
        StatsForCountry(Confirmed: 200, Deaths: 1, Recovered: 40, Date: "2020-04-04T00:00:00Z"),
        StatsForCountry(Confirmed: 300, Deaths: 5, Recovered: 50, Date: "2020-04-05T00:00:00Z"),
        StatsForCountry(Confirmed: 400, Deaths: 6, Recovered: 60, Date: "2020-05-04T00:00:00Z"),
        StatsForCountry(Confirmed: 600, Deaths: 10, Recovered: 80, Date: "2020-06-05T00:00:00Z"),
        StatsForCountry(Confirmed: 30000, Deaths: 150, Recovered: 20000, Date: "2020-11-04T00:00:00Z"),
        StatsForCountry(Confirmed: 33000, Deaths: 150, Recovered: 21000, Date: "2020-11-07T00:00:00Z"),
        StatsForCountry(Confirmed: 36000, Deaths: 160, Recovered: 22000, Date: "2020-11-08T00:00:00Z"),
        StatsForCountry(Confirmed: 38000, Deaths: 150, Recovered: 23000, Date: "2020-11-14T00:00:00Z"),
        StatsForCountry(Confirmed: 39000, Deaths: 200, Recovered: 24000, Date: "2020-11-20T00:00:00Z")
    ]) {
        statsCallback?(stats)
    }
}
