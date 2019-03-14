//
//  ViewController.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = HomeTopNavStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDummyCards()
        setupLayout()
    }
    
    fileprivate func setupDummyCards() {
        let cardView = CardView()
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    }
    
    fileprivate func setupLayout() {
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        mainStackView.axis = .vertical
        
        view.addSubview(mainStackView)
        mainStackView.bringSubviewToFront(cardsDeckView)
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
}
