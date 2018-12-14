//
//  LoginVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loginBg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ tap: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    ///when cancel button is pressed.
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //when dont have an account button is pressed.
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = usernameTxt.text, usernameTxt.text != "" else {return self.alertDisplay(title: "no user name", msg: "give proper user name!")}
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {return self.alertDisplay(title: "no password", msg: "give proper password!")}
        
        loginBg.isHidden = false
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success{
                AuthService.instance.getUserByEmail(completion: { (success) in
                    self.loginBg.isHidden = true
                    self.spinner.stopAnimating()
                    if success{
                        NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                    if !success{
                        self.alertDisplay(title: "Login Failed..!", msg: "Check your credentials and try again.")
                    }
                })
            }else{
                self.loginBg.isHidden = true
                self.spinner.stopAnimating()
                self.alertDisplay(title: "Login Failed..!", msg: "Check your credentials and try again.")
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
