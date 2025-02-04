//
//  ViewController.swift
//  Clima
//
//  Created by Igor Costa Nascimento on 03/02/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    let colorBackgorund: UIColor = .gray.withAlphaComponent(0.3)
    
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
        let image = UIImage(systemName: SymbolsMap.settings.rawValue)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = .gray
        button.backgroundColor = colorBackgorund
        return button
    }()
    
    private lazy var searchInputLabel: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Pesquisa"
        input.font = .systemFont(ofSize: 14)
        input.backgroundColor = colorBackgorund
        input.textColor = .weatherColour
        input.borderStyle = .roundedRect
        return input
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: SymbolsMap.search.rawValue), for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = .gray
        button.backgroundColor = colorBackgorund
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Setup View Controller
    
    func addSubViews(){
        view.addSubview(backgroundImageView)
        view.addSubview(buttonLocation)
        view.addSubview(searchInputLabel)
        view.addSubview(searchButton)
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
            buttonLocation.widthAnchor.constraint(equalToConstant: 32),
            buttonLocation.heightAnchor.constraint(equalToConstant: 32),
            
            //MARK: setup search input
            searchInputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchInputLabel.leadingAnchor.constraint(equalTo: buttonLocation.trailingAnchor, constant: 8),
            searchInputLabel.heightAnchor.constraint(equalToConstant: 32),
            
            //MARK: SETUP SEARCH BUTTON
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchInputLabel.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 32),
            searchButton.heightAnchor.constraint(equalToConstant: 32),

        ])
    }


}

