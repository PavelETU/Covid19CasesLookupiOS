//
//  CountriesDataSource.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import Foundation
import UIKit

class CountriesDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    init(countries: [Country]) {
        self.countries = countries
    }
    
    private let countries: [Country]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].Country
    }
}
