//
//  ViewController.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    var users = [User]()
    
    let topStackView = HomeTopNavStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDummyUsers()
        setupDummyCards()
        setupLayout()
    }
    
    fileprivate func setupDummyUsers() {
        users.append(User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"))
        users.append(User(name: "Rachel", age: 30, profession: "Fashionista", imageName: "lady4c"))
    }
    
    fileprivate func setupDummyCards() {
        users.forEach { (user) in
            let cardView = CardView()
            cardView.user = user
            
            cardsDeckView.addSubview(cardView)
            
            cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
    }
    
    fileprivate func setupLayout() {
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        mainStackView.axis = .vertical
        
        view.addSubview(mainStackView)
        mainStackView.bringSubviewToFront(cardsDeckView)
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
}
