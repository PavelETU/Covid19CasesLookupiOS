//
//  CountryStats.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct CountryStatsScreen: View {
    
    @EnvironmentObject var viewModel: CountryStatsViewModel
    var country: Country
    
    var body: some View {
        getViewForState()
        .navigationBarTitle(Text("Cases in " + country.Country), displayMode: .inline)
        .onAppear {
            self.viewModel.onAppear(country: self.country)
        }
    }
    
    func getViewForState() -> AnyView {
        switch viewModel.state {
        case .success:
            return AnyView(CountryStatsView(countryStats: viewModel.countryStats))
        case .noInfo:
            return AnyView(NoStatsView())
        case .error:
            return AnyView(ErrorView(retryAction: { self.viewModel.onRetry() }))
        case .loading:
            return AnyView(LoadingView())
        }
    }

}

struct CountryStats_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatsScreen(country: Country(Country: "Ireland", Slug: "", ISO2: "")).environmentObject(CountryStatsViewModel(repository: LocalRepository()))
    }
}
