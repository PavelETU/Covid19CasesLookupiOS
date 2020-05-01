//
//  CountryList.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 30/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct CountryList: View {
    
    @EnvironmentObject var viewModel: CasesLookupViewModel
    
    var body: some View {
        NavigationView {
            getViewForState()
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
    
    func getViewForState() -> AnyView {
        switch viewModel.state {
        case .success:
            return AnyView(ListOfCountries(countries: viewModel.countries))
        case .error:
            return AnyView(ErrorView(retryAction: { self.viewModel.onRetry() }))
        case .loading:
            return AnyView(LoadingView())
        }
    }
}

struct CountryList_Previews: PreviewProvider {
    static var previews: some View {
        CountryList().environmentObject(CasesLookupViewModel(repository: PreviewRepository()))
    }
}

class PreviewRepository: CasesLookupRepository {
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        completionCallback([
            Country(Country: "Ireland", Slug: "", ISO2: ""),
            Country(Country: "Russia", Slug: "", ISO2: "")
        ])
    }
}
