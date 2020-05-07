//
//  CasesLookupRobot.swift
//  Covid 19 Cases LookupUITests
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

protocol CasesLookupRobot {
    func givenIHaveAnInternetConnectionAndOpenTheApp()
    func iSeeAScreenOfAvailableCountries()
    func andIClickOnACountryWithATitle(countryTitle: String)
    func iSeeStatsScreenForACountry(countryTitle: String)
    func andIChoseTypeOfCasesWithATitle(typeOfCases: String)
    func iSeeConfirmedCasesFromDataLayerForACountry(countryTitle: String)
    func iSeeDeathCasesFromDataLayerForACountry(countryTitle: String)
    func iSeeRecoveredCasesFromDataLayerForACountry(countryTitle: String)
    func iCanSeeConfirmedCasesForAllAvailableMonths(countryTitle: String)
    func iCanSeeDeathCasesForAllAvailableMonths(countryTitle: String)
    func iCanSeeRecoveredCasesForAllAvailableMonths(countryTitle: String)
}
