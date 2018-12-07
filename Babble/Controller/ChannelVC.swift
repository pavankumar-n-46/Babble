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
    @IBOutlet weak var loginImg: CircleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///specifies the width of which the chatVC should slide to. and the amount the ChannelVC should reveal.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
    }
    
    @objc private func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle("\(UserDataService.instance.name)", for: .normal)
            loginImg.image = UIImage(named: "\(UserDataService.instance.avatarName)")
            loginImg.backgroundColor = UserDataService.instance.getUserAvatorColorFromString(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            loginImg.image = UIImage(named: "menuProfileIcon")
            loginImg.backgroundColor = UIColor.clear
        }
    }
    
    //MARK:- navigation to LoginVC
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
