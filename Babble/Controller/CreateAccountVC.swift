//
//  CreateAccountVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 20/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    ///cancels the opeartion and segues back to the channel VC.
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
