//
//  MessageService.swift
//  Babble
//
//  Created by Pavan Kumar N on 11/12/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    var unReadChannels = [String]()
    
    func findAllChannels(completion: @escaping ((Bool)->Void)){
        
        request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.channels.removeAll()
                if let json = JSON(data: data).array{
                    for index in json{
                        let name = index["name"].stringValue
                        let channelDescription = index["description"].stringValue
                        let id = index["_id"].stringValue
                        let channel = Channel.init(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId : String, completion: @escaping completionHandler){
        let url_path = "\(URL_GET_MESSAGES)/\(channelId)"
        print(url_path)
        request(url_path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil{
                self.messages.removeAll()
                guard let data = response.data else {return}
                if let jsonArray = JSON(data: data).array{
                    for item in jsonArray{
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Message.init(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    completion(true)
                }
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannel(){
        self.channels.removeAll()
    }
    
    func clearMessages(){
        self.messages.removeAll()
    }
    
}
