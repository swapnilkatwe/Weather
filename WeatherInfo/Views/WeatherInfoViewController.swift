//
//  WeatherInfoViewController.swift
//  WeatherInfo
//
//  Created by swapnil.suresh.katwe on 17/03/23.
//

import UIKit
import  Alamofire


class WeatherInfoViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    var viewModel = WeatherInfoViewModel()

    //MARK: - lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getActualLocationWeather()
        currentLocation()
        setup()
    }
    
    private func setup() {
        viewModel.bind = { [weak self] data in
            guard let self = self else { return }
            // bind and relaod new data
            self.cityTitleLabel.text = self.viewModel.cityName
            self.currentDateLabel.text = self.viewModel.currentDate
            self.currentTemperatureLabel.text = self.viewModel.currentTemperature
            self.currentWeather.text = self.viewModel.weatherDescription
            self.weatherStateImageView.loadImage(from: self.viewModel.weatherImageUrl)
        }
    }

    private func currentLocation() {
        DispatchQueue.main.async {
            self.viewModel.getCurrentLocation()
        }
    }
    
    private func getActualLocationWeather() {
        DispatchQueue.main.async {
            self.viewModel.getActualLocationWeather()
        }
    }

    //MARK: - IBActions
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        controller.viewModel.delegate = self.viewModel
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true, completion: nil)
    }
}
