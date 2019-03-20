//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    fileprivate var imageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[imageIndex])
            imageIndexObserver?(image ?? UIImage(), imageIndex)
        }
    }
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    var imageIndexObserver: ((UIImage, Int) -> ())?
    
    func goToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPrevPhoto() {
        imageIndex = max(imageIndex - 1, 0)
    }
}
