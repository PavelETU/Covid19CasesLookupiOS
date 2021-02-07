//
//  CountryStatsViewModel.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import SwiftUI

class CountryStatsViewModel: ObservableObject {
    
    init(repository: CasesLookupRepository) {
        repo = repository
    }
    
    var confirmedCasesByMonth: [[Int]] = [[]]
    var deathsByMonth: [[Int]] = [[]]
    var recoveredByMonth: [[Int]] = [[]]
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
    @Published var monthNumber = 0 {
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
    
    func onAppear(country: Country) {
        self.country = country
        loadCountryStats()
    }
    
    func onRetry() {
        loadCountryStats()
    }
    
    func onDisappear() {
        skipUpdate = true
        monthNumber = 0
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
        monthWithTagList = []
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
        monthNumber = monthIndex
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
            updateValuesToDisplayByData(valuesToProcess: deathsByMonth[monthNumber])
        case 2:
            updateValuesToDisplayByData(valuesToProcess: recoveredByMonth[monthNumber])
        default:
            updateValuesToDisplayByData(valuesToProcess: confirmedCasesByMonth[monthNumber])
        }
    }
    
    private func updateValuesToDisplayByData(valuesToProcess: [Int]) {
        let maxValue = valuesToProcess.max()!
        var normalizedValues = valuesToProcess.map { (CGFloat($0) / CGFloat(maxValue)) }
        var temp:[BarOutputStructure] = []
        for index in 0..<normalizedValues.count {
            if (normalizedValues[index].isNaN) {
                normalizedValues[index] = CGFloat(valuesToProcess[index])
            }
            temp.append(BarOutputStructure(normalizedValue: normalizedValues[index], actualValue: valuesToProcess[index]))
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
            monthStr = "Jan"
        case 2:
            monthStr = "Feb"
        case 3:
            monthStr = "Mar"
        case 4:
            monthStr = "Apr"
        case 5:
            monthStr = "May"
        case 6:
            monthStr = "Jun"
        case 7:
            monthStr = "Jul"
        case 8:
            monthStr = "Aug"
        case 9:
            monthStr = "Sep"
        case 10:
            monthStr = "Oct"
        case 11:
            monthStr = "Nov"
        case 12:
            monthStr = "Dec"
        default:
            monthStr = "Unk"
        }
        return monthStr
    }
}
