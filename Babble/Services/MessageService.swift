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
    
    func findAllChannels(completion: @escaping ((Bool)->Void)){
        
        request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
    
                if let json = JSON(data: data).array{
                    for index in json{
                        let name = index["name"].stringValue
                        let channelDescription = index["description"].stringValue
                        let id = index["_id"].stringValue
                        let channel = Channel.init(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    print(self.channels)
                    completion(true)
                }
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
