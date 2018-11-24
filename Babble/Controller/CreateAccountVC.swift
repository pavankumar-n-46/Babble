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
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    ///cancels the opeartion and segues back to the channel VC.
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatorPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        ///check to see whether the email and pass fields are non empty.
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else{ return }
        guard let pass = passTxt.text, passTxt.text != "" else{ return }
        
        ///calling the registerUser method to register the users.
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                //calls the login user method to login the user.
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(name: name, avatarName: self.avatarName, email: email, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                //calls the add user method to add the user.
                                print(UserDataService.instance.name , UserDataService.instance.avatarName )
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }


}
