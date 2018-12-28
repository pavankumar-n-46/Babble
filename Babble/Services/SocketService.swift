//
//  SocketService.swift
//  Babble
//
//  Created by Pavan Kumar N on 14/12/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func  establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDesc: String,completion:@escaping completionHandler){
        socket.emit("newChannel", channelName, channelDesc)
        completion(true)
    }
    
    func getChannelList(completion:@escaping completionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { print("error"); return}
            guard let channelDesc = dataArray[1] as? String else { print("error"); return}
            guard let channelId = dataArray[2] as? String else { print("error"); return}
            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userID: String, channelID:String, completion: @escaping completionHandler){
        let user = UserDataService.instance
        socket.emit("newMessage",messageBody ,userID, channelID, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getMessages(completion: @escaping completionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { print("error"); return}
            guard let channelID = dataArray[2] as? String else { print("error"); return}
            guard let userName = dataArray[3] as? String else { print("error"); return}
            guard let userAvatar = dataArray[4] as? String else { print("error"); return}
            guard let userAvatarColor = dataArray[5] as? String else { print("error"); return}
            guard let msgID = dataArray[6] as? String else { print("error"); return}
            guard let timeStamp = dataArray[6] as? String else { print("error"); return}
            
            if channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                let newMessage = Message.init(message: messageBody, userName: userName, channelId: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: msgID, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func getTypingUser(_ completion: @escaping ([String: String]) -> Void){
        socket.on("userTypingUpdate") { (data, ack) in
            guard let typingUsers = data[0] as? [String:String] else {return}
            completion(typingUsers)
        }
    }
}
