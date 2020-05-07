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
    private var screenWidth: CGFloat!
    private var skipUpdate = false
    
    @Published var valuesToDisplay: [BarOutputStructure] = []
    @Published var state: StatsScreenStates = StatsScreenStates.loading
    @Published var typeOfCases = 0 {
        didSet {
            if !skipUpdate {
                updateValuesToDisplay()
            } else {
                skipUpdate = false
            }
        }
    }
    
    private let repo: CasesLookupRepository
    private var country: Country!
    
    func onAppear(country: Country, screenWidth: CGFloat) {
        self.country = country
        self.screenWidth = screenWidth
        skipUpdate = true
        typeOfCases = 0
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
            self.state = StatsScreenStates.success
            self.parseCountryStats(countryStats: finalCountryStats)
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
        updateValuesToDisplay()
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
    
    private func updateValuesToDisplay() {
        switch (typeOfCases) {
        case 1:
            updateValuesToDisplayByData(data: deathsByMonth)
        case 2:
            updateValuesToDisplayByData(data: recoveredByMonth)
        default:
            updateValuesToDisplayByData(data: confirmedCasesByMonth)
        }
    }
    
    private func updateValuesToDisplayByData(data: [[Int]]) {
        let lastMonthIndex = data.count - 1
        let valuesToProcess: [Int] = data[lastMonthIndex]
        let maxValue = valuesToProcess.max()!
        let barWidth = screenWidth / CGFloat(valuesToProcess.count) - BarConstants.SPACING_BTW_BARS * 2
        var normalizedValues = valuesToProcess.map { (CGFloat($0) / CGFloat(maxValue)) * BarConstants.MAX_VALUE_OF_BAR }
        var temp:[BarOutputStructure] = []
        for index in 0..<normalizedValues.count {
            if (normalizedValues[index].isNaN) {
                normalizedValues[index] = CGFloat(valuesToProcess[index])
            }
            temp.append(BarOutputStructure(barWidth: barWidth, normalizedValue: normalizedValues[index], actualValue: valuesToProcess[index]))
        }
        valuesToDisplay = temp
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
