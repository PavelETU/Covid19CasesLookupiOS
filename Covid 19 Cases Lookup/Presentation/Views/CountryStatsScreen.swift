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
        GeometryReader { metrics in
            VStack {
                self.getViewForState()
            }
            .onAppear {
                self.viewModel.onAppear(country: self.country)
            }
        }.navigationBarTitle(Text("Cases in " + self.country.Country), displayMode: .inline)
    }
    
    func getViewForState() -> AnyView {
        switch viewModel.state {
        case .success:
            return AnyView(StatsView())
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
        CountryStatsScreen(country: Country(Country: "Ireland", Slug: "ireland", ISO2: "ireland")).environmentObject(CountryStatsViewModel(repository: LocalRepository()))
    }
}
