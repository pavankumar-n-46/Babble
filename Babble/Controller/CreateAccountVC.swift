//
//  CreateAccountVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 20/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    ///cancels the opeartion and segues back to the channel VC.
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatorPressed(_ sender: Any) {
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        ///check to see whether the email and pass fields are non empty.
        guard let email = emailTxt.text, emailTxt.text != "" else{ return }
        guard let pass = passTxt.text, passTxt.text != "" else{ return }
        
        ///calling the registerUser method to register the users.
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
            }
        }
    }


}
