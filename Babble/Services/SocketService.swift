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
            guard let channelDesc = dataArray[0] as? String else { print("error"); return}
            guard let channelId = dataArray[0] as? String else { print("error"); return}
            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}
