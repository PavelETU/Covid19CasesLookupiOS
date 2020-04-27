//
//  View.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

protocol CasesLookupView: AnyObject {
    func displayCountries(countries: [Country])
}
