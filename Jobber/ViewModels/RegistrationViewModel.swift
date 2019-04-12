//
//  RegistrationViewModel.swift
//  Jobber
//
//  Created by Prudhvi Gadiraju on 4/10/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    // use bindable
    var image = Bindable<UIImage>()
    var isRegistering = Bindable<Bool>()
    
    // otherwise normally
    
    var fullName: String? { didSet { checkFromValidity() } }
    var email: String? { didSet { checkFromValidity() } }
    var password: String? { didSet { checkFromValidity() } }
    
    var isFormValidObserver: ((Bool) -> ())?
    
    func registerUser(completion: @escaping (Error?) -> ()) {
        guard let email = email else {return}
        guard let password = password else {return}
                
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            if let error = error { completion(error) }
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: filename)
        let imageData = self.image.value?.jpegData(compressionQuality: 0.75) ?? Data()
        
        ref.putData(imageData, metadata: nil, completion: { (_, error) in
            if let error = error { completion(error) }
            ref.downloadURL(completion: { (url, error) in
                if let error = error { completion(error) }
                guard let urlString = url?.absoluteString else { return }
                self.saveInfoToFirestore(imageUrl: urlString, completion: completion)
            })
            completion(nil)
        })
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = [
            "fullname": fullName ?? "",
            "uid": uid,
            "imageUrl1": imageUrl
        ]
        
        Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
            if let error = error { completion(error) }
            completion(nil)
        }
    }
    
    fileprivate func checkFromValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
}
