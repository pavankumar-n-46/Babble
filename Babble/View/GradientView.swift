//
//  GradientView.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit


/// An IBDesignable UIView Class used to get Gradient effect to the view.
@IBDesignable
class GradientView: UIView {
   
    /// top color of the gradient which is also @IBInspectable
    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    /// bottom color of the gradient which is also @IBInspectable
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    /// func in which the CAGradientLayer is used, and the logic is implemented to apply the gradient effects.
    override func layoutSubviews() {
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        /// if you miss out to add .cgColot then this won't work, I scratched my head so much for this mistake.
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
