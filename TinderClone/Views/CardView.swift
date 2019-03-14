//
//  CardView.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/13/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 14
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let originalFrame = frame
        print(originalFrame)

        switch gesture.state {
        case .changed:
            handlePanChanged(gesture)
            break
            
        case .ended:
            handlePanEnded(gesture, originalFrame)
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
    
    fileprivate func handlePanEnded(_ gesture: UIPanGestureRecognizer, _ originalFrame: CGRect) {
        
        let threshold: CGFloat = 100
        let translation = gesture.translation(in: superview)
        
        let shouldDismissCard = abs(translation.x) > threshold
        let dismissRight = translation.x > 0
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
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
            UIView.animate(withDuration: 0.25, delay: 1.0, options: .curveEaseOut, animations: {
                self.transform = .identity
                self.frame = CGRect(x: 12, y: 0, width: self.superview!.frame.width-24, height: self.superview!.frame.height)
            }, completion: nil)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
