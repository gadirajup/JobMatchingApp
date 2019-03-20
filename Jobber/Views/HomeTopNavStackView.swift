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
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fireImageView.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        [settingsButton, fireImageView, messageButton].forEach({ (view) in
            addArrangedSubview(view)
        })
        
        //StackView Settings
        axis = .horizontal
        distribution = .equalCentering
        
        //StackView Constraints
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
