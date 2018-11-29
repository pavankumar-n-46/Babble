//
//  RoundedImage.swift
//  Babble
//
//  Created by Pavan Kumar N on 29/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

@IBDesignable class CircleImage: UIImageView {

    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    

}
