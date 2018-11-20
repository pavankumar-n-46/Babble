//
//  ChannelVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///specifies the width of which the chatVC should slide to. and the amount the ChannelVC should reveal.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    //MARK:- navigation to LoginVC
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
