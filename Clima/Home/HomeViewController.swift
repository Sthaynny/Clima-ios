//
//  ViewController.swift
//  Clima
//
//  Created by Igor Costa Nascimento on 03/02/25.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let colorBackgorund: UIColor = .gray.withAlphaComponent(0.3)
    
    var weatherManager = WeatherManager()
    let weatherView = WeatherView()
    
    let locationManager = CLLocationManager()
    
    private lazy var backgroundImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var buttonLocation: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if  let image = UIImage(systemName: SymbolsMap.locationFill.rawValue){
            button.setBackgroundImage(image, for: .normal)
        }
        button.contentMode = .scaleAspectFill
        button.tintColor = .weatherColour
        button.addTarget(self, action: #selector(locationActionButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchInputLabel: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Pesquisa"
        input.font = .systemFont(ofSize: 24)
        input.backgroundColor = colorBackgorund
        input.textColor = .weatherColour
        input.tintColor = .weatherColour
        input.textAlignment = .right
        input.borderStyle = .roundedRect
        input.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
       
        return input
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if  let image = UIImage(systemName: SymbolsMap.search.rawValue){
            button.setBackgroundImage(image, for: .normal)
        }
        button.contentMode = .scaleAspectFill
        button.tintColor = .weatherColour
        button.addTarget(self, action: #selector(searchTapButton), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        addSubViews()
        setupConstraints()
        weatherManager.delegate = self
        searchInputLabel.delegate = self
    }
    
    
    //MARK: Setup View Controller
    
    func addSubViews(){
        view.addSubview(backgroundImageView)
        view.addSubview(buttonLocation)
        view.addSubview(searchInputLabel)
        view.addSubview(searchButton)
        view.addSubview(weatherView)
        weatherView.translatesAutoresizingMaskIntoConstraints = false
         
    }
    
  
    func setupConstraints(){
        NSLayoutConstraint.activate([
            //MARK: setup background color app
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //MARK: setup button location app
            buttonLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLocation.widthAnchor.constraint(equalToConstant: 40),
            buttonLocation.heightAnchor.constraint(equalToConstant: 40),
            
            //MARK: setup search input
            searchInputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchInputLabel.leadingAnchor.constraint(equalTo: buttonLocation.trailingAnchor, constant: 8),
            searchInputLabel.heightAnchor.constraint(equalToConstant: 40),
            
            //MARK: SETUP SEARCH BUTTON
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchInputLabel.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            //MARK: SETUP Winter View
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 78),

        ])
    }
    
    @objc func searchTapButton(){
        if let city = searchInputLabel.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchInputLabel.text = ""
    }


}



//MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    
    @objc func searchPressed() {
        searchInputLabel.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchInputLabel.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Pesquisar"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchInputLabel.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchInputLabel.text = ""
        
    }
}


//MARK: WeatherManagerDelegate
extension HomeViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.weatherModel = weather
        }
    }
    
    func didFailWithError(error: any Error) {
//        let alert = UIAlertController(title: "Erro ao obter Clima", message: "Não Foi possivel obter o clima na localização solicitada.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default))
//        present(alert, animated: true)
        DispatchQueue.main.async {
            sleep(1)
            self.weatherView.weatherModel = WeatherModel(conditionId: 300, cityName: "Cajazeiras", temperature: 22)
            self.weatherView.updateView()
        }
    }
    
    
}



//MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    
    @objc func locationActionButton() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lat: \(lat), log: \(lon)")
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Erro ao obter permissão", message: "Não Foi possivel obtter a permissão de localização", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
