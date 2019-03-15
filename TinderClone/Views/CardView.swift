//
//  CardView.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CardView: UIView {
    var imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    var informationLabel = UILabel()
    
    var user: User! {
        didSet {
            setupLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGestures()
    }

    //MARK:- Setup Functions
    
    fileprivate func setupLayout() {
        setupView()
        setupImageView()
        setupInformationLabel()
    }
    
    fileprivate func setupInformationLabel() {
        informationLabel.attributedText = getAttributedInformationText()
        informationLabel.numberOfLines = 2
        informationLabel.textColor = .white
        informationLabel.textAlignment = .left
        
        addSubview(informationLabel)
        
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func setupImageView() {
        imageView.image = UIImage(named: user.imageName)
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        
        imageView.fillSuperview()
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 14
        clipsToBounds = true
    }
    
    fileprivate func setupGestures() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    //MARK:- Gesture Functions
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handlePanChanged(gesture)
            break
        case .ended:
            handlePanEnded(gesture)
            break
        default:
            break
        }
    }
    
    fileprivate func handlePanChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview)
        let rotationAngle = translation.x / 1080
        
        let translationTranformation = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotationTransformation = CGAffineTransform(rotationAngle: rotationAngle)
        
        transform = translationTranformation.concatenating(rotationTransformation)
    }
    
    fileprivate func handlePanEnded(_ gesture: UIPanGestureRecognizer) {
        let threshold: CGFloat = 100
        let translation = gesture.translation(in: superview)
        
        let shouldDismissCard = abs(translation.x) > threshold
        let dismissRight = translation.x > 0
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                if dismissRight {
                    self.frame = CGRect(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
                } else {
                    self.frame = CGRect(x: -1000, y: 0, width: self.frame.width, height: self.frame.height)
                }
            } else {
                self.transform = .identity
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.10, delay: 1.0, options: .curveEaseOut, animations: {
                self.transform = .identity
                self.frame = CGRect(x: 12, y: 0, width: self.superview!.frame.width-24, height: self.superview!.frame.height)
                if shouldDismissCard {
                    self.removeFromSuperview()
                }
            }, completion: nil)
        })
    }
    
    //MARK:- Helper Functions
    
    fileprivate func getAttributedInformationText() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return attributedText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}