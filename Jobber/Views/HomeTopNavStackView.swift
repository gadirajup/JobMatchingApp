//
//  HomeTopNavStackView.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class HomeTopNavStackView: UIStackView {

    let height: CGFloat = 80
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let logo = UIImageView(image: #imageLiteral(resourceName: "TitleLogo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    fileprivate func setup() {
        setupUI()
        setupStackView()
    }
    
    fileprivate func setupUI() {
        settingsButton.setImage(#imageLiteral(resourceName: "Profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "Messages").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    fileprivate func setupStackView() {
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        [settingsButton, messageButton].forEach({ (view) in
            addArrangedSubview(view)
        })
        
        alignment = .center
        
        //StackView Settings
        axis = .horizontal
        distribution = .equalCentering
        
        //StackView Constraints
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
