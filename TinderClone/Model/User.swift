//
//  User.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/14/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        return CardViewModel(imageName: imageName, attributedString: getAttributedInformationText(), textAlignment: .left)
    }
    
    fileprivate func getAttributedInformationText() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return attributedText
    }
}
