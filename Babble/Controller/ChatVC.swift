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
    @IBOutlet weak var chatLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///SWReveal button, which specifies either to reveal or hide the hamburger menu upon touching the hamburger.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        ///this are the gustures to for the SWRevealViewController.
        self.view.addGestureRecognizer((self.revealViewController()!.panGestureRecognizer()))
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.getUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
            }
            MessageService.instance.findAllChannels { (success) in
                print("succes")
            }
        }
    }
    
    @objc private func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            chatLbl.text = "please login"
        }
    }
    
    @objc private func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelTxt = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatLbl.text = "#\(channelTxt)"
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                //do with channels
            }
        }
    }
    
}
