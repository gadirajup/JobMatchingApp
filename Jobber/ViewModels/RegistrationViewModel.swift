//
//  RegistrationViewModel.swift
//  Jobber
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    var fullName: String? { didSet { checkFromValidity() } }
    var email: String? { didSet { checkFromValidity() } }
    var password: String? { didSet { checkFromValidity() } }
    
    var isFormValidObserver: ((Bool) -> ())?
    
    fileprivate func checkFromValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
}
