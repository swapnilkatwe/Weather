//
//  SearchViewModel.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 19/03/23.
//

import Foundation
import CoreLocation

protocol SearchViewModelDelegate: AnyObject {
    func locationUpdated()
}

class SearchViewModel: NSObject {
    
    //MARK: - vars
    var reloadTablView: (()->())?
    weak var delegate: SearchViewModelDelegate?
    private var filteredCities = CityList()

    private var cellViewModel = [SearchCellViewModel]() {
        didSet {
            self.reloadTablView?()
        }
    }
    
    var numberOfCell: Int {
        filteredCities.count
    }
    
    //MARK: - flow func
    
    func didSelectRow(at indexPath: IndexPath) {
        
        // save lat long in shared object
        guard let latitude = filteredCities[indexPath.row].lat,
              let longitude = filteredCities[indexPath.row].lon else { return }

        SessionManager.shared.currentCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        self.delegate?.locationUpdated()
    }
    
    func searchCity(text: String) {
        
        WeatherManager.shared.searchResults(searchText: text) { [weak self] result in
            switch result {
            case .success(let cityList):
                self?.filteredCities = cityList
                self?.createCell()
                print("-->\(cityList)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SearchCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func filteredCityIsEmpty() -> Bool {
        filteredCities.isEmpty
    }
    
    private func createCell(){
        var viewModelCell = [SearchCellViewModel]()
        for city in filteredCities {
            viewModelCell.append(SearchCellViewModel(city: city.name ?? "-", country: city.country ?? "-"))
        }
        cellViewModel = viewModelCell
    }
}

struct SearchCellViewModel {
    var city: String
    var country: String
}
