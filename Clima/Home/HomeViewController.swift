//
//  ViewController.swift
//  Clima
//
//  Created by Igor Costa Nascimento on 03/02/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var backgroundImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

