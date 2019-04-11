//
//  Bindable.swift
//  Jobber
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ( (T?) -> () )?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
