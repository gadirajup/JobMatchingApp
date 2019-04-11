//
//  HomeBottomControlsStackView.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    let height: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomSubviews = [#imageLiteral(resourceName: "No"), #imageLiteral(resourceName: "Yes")].map { (image) -> UIButton in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        bottomSubviews.forEach { (view) in
            addArrangedSubview(view)
        }
        
        //StackView Settings
        axis = .horizontal
        distribution = .fillEqually
        
        //StackView Constraints
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
