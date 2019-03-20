//
//  CustomTextField.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    let padding: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 25
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
