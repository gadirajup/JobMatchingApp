//
//  ViewController.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    // MARK:- Properties
    var cardViewModels = [CardViewModel]()
    
    // MARK:- UI Elements
    
    let topStackView = HomeTopNavStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
    
    // MARK:- Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDummyCardViewModels()
        setupDummyCards()
        setupLayout()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
    }
    
    fileprivate func setupDummyCardViewModels() {
        let dummyModels = [
            Advertiser(title: "Need Coffee", brandName: "Keep your coffee hot!", posterPhotoName: "coffee"),
            User(name: "Phoebe", age: 23, profession: "Music DJ", imageNames: ["lady5c", "lady4c"]),
            User(name: "Monica", age: 30, profession: "Fashionista", imageNames: ["lady4c"]),
            User(name: "Rachel", age: 30, profession: "Fashionista", imageNames: ["Rachel1", "Rachel2", "Rachel3"])
            ] as [ProducesCardViewModel]
        
        dummyModels.forEach { (model) in
            self.cardViewModels.append(model.toCardViewModel())
        }
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView()
            cardView.cardViewModel = cardViewModel
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        mainStackView.axis = .vertical
        
        view.addSubview(mainStackView)
        
        mainStackView.bringSubviewToFront(cardsDeckView)
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    // MARK:- Handlers
    
    @objc fileprivate func handleSettings() {
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }
}
