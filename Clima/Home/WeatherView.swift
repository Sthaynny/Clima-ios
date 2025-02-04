//
//  WinterView.swift
//  Clima
//
//  Created by Igor Costa Nascimento on 04/02/25.
//

import UIKit



class WeatherView: UIView {
    
    var weatherModel: WeatherModel?
    
    private lazy var imageWinter: UIImageView = {
        let image = UIImage(systemName: weatherModel?.conditionName ?? SymbolsMap.rain.rawValue)
        let imageView  = UIImageView(image: image)
        imageView.tintColor = .weatherColour
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(weatherModel?.temperatureString ?? "-" )°C"
        label.font = .systemFont(ofSize: 52, weight: .semibold)
        label.textColor = .weatherColour
        return label
    }()
    
    private lazy var cityLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = weatherModel?.cityName ?? "-"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .weatherColour
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        addSubview(imageWinter)
        addSubview(temperatureLabel)
        addSubview(cityLabel)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageWinter.topAnchor.constraint(equalTo: topAnchor),
            imageWinter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageWinter.widthAnchor.constraint(equalToConstant: 64),
            
            temperatureLabel.topAnchor.constraint(equalTo: imageWinter.bottomAnchor, constant: 24),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    
    func updateView(){
        self.temperatureLabel.text = weatherModel?.temperatureString ?? "-"
        self.imageWinter.image = UIImage(systemName: weatherModel?.conditionName ?? SymbolsMap.rain.rawValue)
        self.cityLabel.text = weatherModel?.cityName ?? "-"
    }

}
