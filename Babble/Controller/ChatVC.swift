//
//  ChatVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var chatLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUsers: UILabel!
    
    //vars
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard upshift
        view.bindToKeyboard()
        
        //Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTaps(_:)))
        view.addGestureRecognizer(tap)
        
        //send btn
        sendBtn.isHidden = true 
        
        //SWReveal button, which specifies either to reveal or hide the hamburger menu upon touching the hamburger.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //table view
        tableView.dataSource = self
        tableView.delegate = self
        
        //making tableview cell height dynamic
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        //this are the gustures to for the SWRevealViewController.
        self.view.addGestureRecognizer((self.revealViewController()!.panGestureRecognizer()))
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        
        //notificaiton observers
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        //socket get new messages
        SocketService.instance.getMessages { (success) in
            if success{
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
                } 
            }
        }
        
        SocketService.instance.getTypingUser { (typingUsers) in
            guard let channelID = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser,channel) in typingUsers{
                if typingUser != UserDataService.instance.name && channel == channelID{
                    if names == ""{
                        names = typingUser
                    }else{
                        names += " \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true{
                var verb = "is"
                if numberOfTypers > 1{
                    verb = "are"
                }
                self.typingUsers.text = "\(names) \(verb) typing a message"
            }else{
                self.typingUsers.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.getUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DID_CHANGE, object: nil)
            }
            MessageService.instance.findAllChannels { (success) in
                print("succes")
            }
        }
    }
    
    @objc func handleTaps(_ gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc private func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            chatLbl.text = "please login"
            tableView.reloadData()
        }
    }
    
    @objc private func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelTxt = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatLbl.text = "#\(channelTxt)"
        getMessages()
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.chatLbl.text = "no channels yet!"
                }
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelID = MessageService.instance.selectedChannel?.id else {return debugPrint("channelID not found in message Service")}
            guard let messageTxt = messageTxtBox.text else { return debugPrint("empty message")}
            SocketService.instance.addMessage(messageBody: messageTxt, userID: UserDataService.instance.id, channelID: channelID) { (success) in
                if success{
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType",UserDataService.instance.name, channelID)
                }
            }
        }
    }
    
    @IBAction func msgBoxEditing(_ sender: Any) {
        guard let channelID = MessageService.instance.selectedChannel?.id else {return}
        if messageTxtBox.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelID)
        }else{
            if isTyping == false{
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelID)
            }
            isTyping = true
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    
    //table view stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
       }else{
            return UITableViewCell()
        }
    }
    
}
