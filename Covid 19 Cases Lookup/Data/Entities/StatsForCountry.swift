//
//  StatsForCountry.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

struct StatsForCountry: Decodable, Hashable, Identifiable {
    let id = UUID()
    let Confirmed: Int
    let Deaths: Int
    let Recovered: Int
    let Date: String
}
