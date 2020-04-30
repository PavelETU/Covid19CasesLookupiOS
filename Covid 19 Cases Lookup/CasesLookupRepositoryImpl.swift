//
//  CasesLookupRepositoryImpl.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation

class CasesLookupRepositoryImpl: CasesLookupRepository {
    func loadCountries(completionCallback: @escaping ([Country]?) -> ()) {
        let url = URL(string: "https://api.covid19api.com/countries")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.handleClientError(error: error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(errorResponse: response!)
                    return
            }
            guard let countriesArray = try? JSONDecoder().decode([Country].self, from: data!) else {
                return
            }
            DispatchQueue.main.async {
                completionCallback(countriesArray)
            }
        }
        task.resume()
    }
    
    private func handleClientError(error: Error) {
        
    }
    
    private func handleServerError(errorResponse: URLResponse) {
        
    }
}
