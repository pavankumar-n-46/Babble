//
//  ChannelVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil{
            self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        }
    }


}
