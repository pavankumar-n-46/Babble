//
//  ProfileVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 07/12/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //outlets
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logout()
        NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.getUserAvatorColorFromString(components: UserDataService.instance.avatarColor)
    }
    
}
