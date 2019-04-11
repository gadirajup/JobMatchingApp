//
//  CardView.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // Properties
    let dismissDuration = 0.75
    let returnDuration = 0.10
    let returnDelay = 1.0
    let maxRotationAngle = 1080
    let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    fileprivate var imageIndex = 0
    var cardViewModel: CardViewModel! {
        didSet {
            setupLayout()
        }
    }
    

    // UI Elements
    fileprivate var imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate var informationLabel = UILabel()
    fileprivate var barsStackView = UIStackView()
    
    
    // Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGestures()
    }
    
    fileprivate func setupLayout() {
        setupView()
        setupImageView()
        setupInformationLabel()
        setupBars()
    }
    
    fileprivate func setupBars() {
        guard cardViewModel.imageNames.count > 1 else {return}
        
        addSubview(barsStackView)
        
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 4))
        
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
        
        (0..<cardViewModel.imageNames.count).forEach { (_) in
            let barView = UIView()
            barView.layer.cornerRadius = 2
            barView.backgroundColor = barDeselectedColor
            barsStackView.addArrangedSubview(barView)
        }
        
        barsStackView.arrangedSubviews.first?.backgroundColor = .white
    }
    
    fileprivate func setupInformationLabel() {
        addSubview(informationLabel)
        
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.attributedText = cardViewModel.attributedString
        informationLabel.numberOfLines = 2
        informationLabel.textColor = .white
        informationLabel.textAlignment = cardViewModel.textAlignment
    }
    
    fileprivate func setupImageView() {
        addSubview(imageView)
        
        imageView.fillSuperview(padding: UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8))
        
        imageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.addClearBlackGradientLayer()
        setupImageIndexObserver()
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { image, index in
            self.imageView.image = image
            self.updateBars(index)
        }
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 14
        clipsToBounds = false
    }
    
    fileprivate func setupGestures() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    //MARK:- Update Functions
    
    func updateBars(_ index: Int) {
        resetBarStackview()
        barsStackView.arrangedSubviews[index].backgroundColor = .white
    }
    
    //MARK:- Gesture Functions
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        guard cardViewModel.imageNames.count > 1 else {return}
        
        let tapLocation = gesture.location(in: nil)
        
        if tapLocation.x > frame.width/2 { cardViewModel.goToNextPhoto() }
        if tapLocation.x < frame.width/2 { cardViewModel.goToPrevPhoto() }
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            handlePanBegan()
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
    
    fileprivate func handlePanBegan() {
        superview?.subviews.forEach({ (subview) in
            subview.layer.removeAllAnimations()
        })
    }
    
    fileprivate func handlePanChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview)
        let rotationAngle = translation.x / CGFloat(maxRotationAngle)
        
        let translationTranformation = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotationTransformation = CGAffineTransform(rotationAngle: rotationAngle)
        
        transform = translationTranformation.concatenating(rotationTransformation)
    }
    
    fileprivate func handlePanEnded(_ gesture: UIPanGestureRecognizer) {
        let threshold: CGFloat = 100
        let translation = gesture.translation(in: superview)
        
        let shouldDismissCard = abs(translation.x) > threshold
        let dismissRight = translation.x > 0
        
        UIView.animate(withDuration: dismissDuration, delay: 0, options: .curveEaseOut, animations: {
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
            UIView.animate(withDuration: self.returnDuration, delay: self.returnDelay, options: .curveEaseOut, animations: {
                self.transform = .identity
                self.frame = CGRect(x: 12, y: 0, width: self.superview!.frame.width-24, height: self.superview!.frame.height)
                if shouldDismissCard {
                    self.removeFromSuperview()
                }
            }, completion: nil)
        })
    }
    
    //MARK:- Helper Functions
    
    fileprivate func resetBarStackview() {
        barsStackView.arrangedSubviews.forEach { (v) in
            v.backgroundColor = barDeselectedColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
