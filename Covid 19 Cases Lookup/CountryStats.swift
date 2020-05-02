//
//  CountryStats.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct CountryStats: View {
    var country: Country
    
    var body: some View {
        VStack {
            Text("Stats for " + country.Country)
        }.navigationBarTitle(Text("Cases in " + country.Country), displayMode: .inline)
    }
}

struct CountryStats_Previews: PreviewProvider {
    static var previews: some View {
        CountryStats(country: Country(Country: "Ireland", Slug: "", ISO2: ""))
    }
}
