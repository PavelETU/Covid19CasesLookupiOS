//
//  ListOfCountries.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 01/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct ListOfCountries: View {
    var countries: [Country]
    var body: some View {
        List(countries) { country in
            Text(country.Country)
        }
        .navigationBarTitle("Pick a country")
        .navigationBarHidden(false)
    }
}

struct ListOfCountries_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountries(countries: [
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: "")
        ])
    }
}
