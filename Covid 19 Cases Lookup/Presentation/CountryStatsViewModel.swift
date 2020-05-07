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
    @Published var monthWithTagList: [MonthWithTag] = []
    
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
        monthWithTagList.append(MonthWithTag(month: countryStats.first!.getMonthTitle(), tag: monthIndex))
        self.addStatsToVariables(indexToAdd: monthIndex, statsToAdd: countryStats.first!)
        for (index, element) in countryStats.enumerated().dropFirst() {
            if (countryStats[index - 1].monthsAreDifferent(statsToCompare: element)) {
                monthIndex += 1
                self.addNewMonthToStats()
                monthWithTagList.append(MonthWithTag(month: element.getMonthTitle(), tag: monthIndex))
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

struct MonthWithTag: Hashable {
    let month: String
    let tag: Int
}

extension StatsForCountry {
    func monthsAreDifferent(statsToCompare: StatsForCountry) -> Bool {
        return getMonthFromDate() != statsToCompare.getMonthFromDate()
    }
    
    func getMonthFromDate() -> Int {
        let start = Date.index(Date.startIndex, offsetBy: 5)
        let end = Date.index(Date.endIndex, offsetBy: -14)
        return Int(Date[start...end]) ?? -1
    }
    
    func getMonthTitle() -> String {
        var monthStr = ""
        switch getMonthFromDate() {
        case 1:
            monthStr = "January"
        case 2:
            monthStr = "February"
        case 3:
            monthStr = "March"
        case 4:
            monthStr = "April"
        case 5:
            monthStr = "May"
        case 6:
            monthStr = "June"
        case 7:
            monthStr = "July"
        case 8:
            monthStr = "August"
        case 9:
            monthStr = "September"
        case 10:
            monthStr = "October"
        case 11:
            monthStr = "November"
        case 12:
            monthStr = "December"
        default:
            monthStr = "Unknown"
        }
        return monthStr
    }
}
