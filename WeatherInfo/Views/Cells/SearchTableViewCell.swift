//
//  SearchTableViewCell.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 19/03/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var cityName: UILabel!

    func configure(filteredCities: SearchCellViewModel) {
        cityName.text = filteredCities.city
        countryName.text = filteredCities.country
    }
}
