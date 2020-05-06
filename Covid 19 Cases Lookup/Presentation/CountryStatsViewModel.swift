//
//  CountryStatsViewModel.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import SwiftUI

struct BarConstants {
    static let MAX_VALUE_OF_BAR: CGFloat = 300
    static let SPACING_BTW_BARS: CGFloat = 1
}

class CountryStatsViewModel: ObservableObject {
    
    init(repository: CasesLookupRepository) {
        repo = repository
    }
    
    var confirmedCasesByMonth: [[Int]] = [[]]
    var deathsByMonth: [[Int]] = [[]]
    var recoveredByMonth: [[Int]] = [[]]
    var screenWidth: CGFloat = 1000
    
    @Published var valuesToDisplay: [BarOutputStructure] = []
    @Published var state: StatsScreenStates = StatsScreenStates.loading
    
    private let repo: CasesLookupRepository
    private var country: Country!
    
    func onAppear(country: Country, screenWidth: CGFloat) {
        self.country = country
        self.screenWidth = screenWidth
        loadCountryStats()
    }
    
    func onRetry() {
        loadCountryStats()
    }
    
    private func loadCountryStats() {
        repo.loadStatsForCountry(country: country, completionCallback: { countryStats in
            guard let finalCountryStats = countryStats else {
                self.state = StatsScreenStates.error
                return
            }
            if (finalCountryStats.isEmpty) {
                self.state = StatsScreenStates.noInfo
                return
            }
            self.parseCountryStats(countryStats: finalCountryStats)
            self.state = StatsScreenStates.success
        })
    }
    
    private func parseCountryStats(countryStats: [StatsForCountry]) {
        confirmedCasesByMonth = [[]]
        deathsByMonth = [[]]
        recoveredByMonth = [[]]
        var monthIndex = 0
        self.addStatsToVariables(indexToAdd: monthIndex, statsToAdd: countryStats.first!)
        for (index, element) in countryStats.enumerated().dropFirst() {
            if (countryStats[index - 1].isStatsFromPreviousMonths(statsToCompare: element)) {
                monthIndex += 1
                self.addNewMonthToStats()
            }
            self.addStatsToVariables(indexToAdd: monthIndex, statsToAdd: element)
        }
        populateValuesToDisplayWithStatsForTheLastMonth()
    }
    
    private func populateValuesToDisplayWithStatsForTheLastMonth() {
        let lastMonthIndex = confirmedCasesByMonth.count - 1
        let valuesToProcess: [Int] = confirmedCasesByMonth[lastMonthIndex]
        let maxValue = valuesToProcess.max()!
        let barWidth = screenWidth / CGFloat(valuesToProcess.count) - BarConstants.SPACING_BTW_BARS * 2
        let normalizedValues = valuesToProcess.map { (CGFloat($0) / CGFloat(maxValue)) * BarConstants.MAX_VALUE_OF_BAR }
        var temp:[BarOutputStructure] = []
        for index in 0..<normalizedValues.count {
            temp.append(BarOutputStructure(barWidth: barWidth, normalizedValue: normalizedValues[index], actualValue: valuesToProcess[index]))
        }
        valuesToDisplay = temp
    }
    
    private func addStatsToVariables(indexToAdd: Int, statsToAdd: StatsForCountry) {
        self.confirmedCasesByMonth[indexToAdd].append(statsToAdd.Confirmed)
        self.deathsByMonth[indexToAdd].append(statsToAdd.Deaths)
        self.recoveredByMonth[indexToAdd].append(statsToAdd.Recovered)
    }
    
    private func addNewMonthToStats() {
        self.confirmedCasesByMonth.append(Array())
        self.deathsByMonth.append(Array())
        self.recoveredByMonth.append(Array())
    }
}

enum StatsScreenStates {
    case loading
    case noInfo
    case success
    case error
}


struct BarOutputStructure: Hashable {
    let barWidth: CGFloat
    let normalizedValue: CGFloat
    let actualValue: Int
}

extension StatsForCountry {
    func isStatsFromPreviousMonths(statsToCompare: StatsForCountry) -> Bool {
        let start = Date.index(Date.startIndex, offsetBy: 5)
        let end = Date.index(Date.endIndex, offsetBy: -14)
        let monthSubstring = Int(Date[start...end]) ?? -1
        let comparingMonth = Int(statsToCompare.Date[start...end]) ?? -1
        return monthSubstring < comparingMonth
    }
}
