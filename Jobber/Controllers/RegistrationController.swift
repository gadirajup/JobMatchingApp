//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {
    
    // Properties
    let registrationViewModel = RegistrationViewModel()

    
    // UI Elements
    let gradientLayer = CAGradientLayer()
    let selectPhotoButton = UIButton(type: .system)
    let fullNameTextField = CustomTextField()
    let emailTextField = CustomTextField()
    let passwordTextField = CustomTextField()
    let registerButton = UIButton(type: .system)
    lazy var stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
    
    
    // Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNotificationObservers()
        setupGestures()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.frame
    }
    
    //MARK:- Setup Functions
    
    fileprivate func setup() {
        setupView()
        setupSelectPhotoButton()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupRegisterButton()
        setupStackView()
    }
    
    fileprivate func setupRegistrationViewModelObserver() {
        registrationViewModel.isFormValidObserver = { [weak self] (isFormValid) in
            self?.registerButton.isEnabled = isFormValid
            
            if isFormValid {
                self?.registerButton.backgroundColor = Theme.theme.purple
            } else {
                self?.registerButton.backgroundColor = #colorLiteral(red: 0.8875266314, green: 0.8822509646, blue: 0.8915820718, alpha: 1)
            }
        }
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture)))
    }
    
    fileprivate func setupView() {
        setupGradientLayer()
    }
    
    fileprivate func setupSelectPhotoButton() {
        selectPhotoButton.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        selectPhotoButton.setTitle("Select Photo", for: .normal)
        selectPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        selectPhotoButton.setTitleColor(.black, for: .normal)
        selectPhotoButton.backgroundColor = .white
        selectPhotoButton.layer.cornerRadius = 12
    }
    
    fileprivate func setupFullNameTextField() {
        fullNameTextField.placeholder = "Enter full name"
        fullNameTextField.backgroundColor = .white
        fullNameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    }
    
    fileprivate func setupEmailTextField() {
        emailTextField.placeholder = "Enter email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.backgroundColor = .white
        emailTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    }
    
    fileprivate func setupPasswordTextField() {
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white
        passwordTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    }
    
    fileprivate func setupRegisterButton() {
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitleColor(.gray, for: .disabled)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        registerButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        registerButton.layer.cornerRadius = 25
        registerButton.isEnabled = false
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
    
    fileprivate func setupStackView() {
        view.addSubview(stackView)
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 48, bottom: 0, right: 48))
        stackView.centerInSuperview()
        
        stackView.axis = .vertical
        stackView.spacing = 12
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [Theme.theme.purple.cgColor, Theme.theme.pink.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
    }
    
    //MARK:- Handle Functions
    
    @objc
    fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        
        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    @objc
    fileprivate func handleKeyboardHide(notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    @objc
    fileprivate func handleTapGesture(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    @objc
    fileprivate func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        let homeController = HomeController()
        present(homeController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            registrationViewModel.fullName = textField.text
        } else if textField == emailTextField {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    @objc fileprivate func handleRegister() {
        self.handleTapGesture(gesture: UITapGestureRecognizer())
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
            if let error = error {
                self.showHUDWithError(error: error)
            }
        }
    }
    
    fileprivate func showHUDWithError(error: Error) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
        
    }
}

