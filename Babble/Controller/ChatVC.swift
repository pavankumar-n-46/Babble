//
//  ChatVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///SWReveal button, which specifies either to reveal or hide the hamburger menu upon touching the hamburger.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        ///this are the gustures to for the SWRevealViewController.
        self.view.addGestureRecognizer((self.revealViewController()!.panGestureRecognizer()))
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
    }
    
}
