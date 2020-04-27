//
//  ViewController.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CasesLookupView {
    @IBOutlet weak var countriesList: UIPickerView!
    
    private var presenter: CasesLookupPresenter!
    private var countriesDataSource: CountriesDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CasesLookupPresenterImpl(repository: CasesLookupRepositoryImpl(), view: self)
    }

    func displayCountries(countries: [Country]) {
        countriesDataSource = CountriesDataSource(countries: countries)
        countriesList.dataSource = countriesDataSource
        countriesList.delegate = countriesDataSource
    }
}

