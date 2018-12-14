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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var loadingBgView: UIView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDataService.instance.avatarName != ""{
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        if avatarName.contains("light") && bgColor == nil{
            userImage.backgroundColor = UIColor.lightGray
        }
    }

    
    ///cancels the opeartion and segues back to the channel VC.
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func chooseAvatorPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        self.bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        self.avatarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.2){
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        loadingBgView.isHidden = false
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
                            self.spinner.stopAnimating()
                            self.loadingBgView.isHidden = true
                            if success{
                                //calls the add user method to add the user.
                                print(UserDataService.instance.name , UserDataService.instance.avatarName )
                                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                            else{
                                self.alertDisplay(title: "Error..!", msg: "Error Creating Account.")
                            }
                        })
                    }
                })
            }
        }
    }
    
    //utility
    private func alertDisplay(title: String, msg: String){
        let alertStr = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)] )
        let alert = UIAlertController(title: alertStr.string, message: msg, preferredStyle: .alert)
        alert.setValue(alertStr, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }


}
