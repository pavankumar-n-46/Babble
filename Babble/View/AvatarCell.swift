//
//  AvatarCell.swift
//  Babble
//
//  Created by Pavan Kumar N on 24/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    //outlets
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
}
