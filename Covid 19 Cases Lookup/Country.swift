//
//  Country.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

struct Country: Decodable, Hashable {
    let Country: String
    let Slug: String
    let ISO2: String
}
