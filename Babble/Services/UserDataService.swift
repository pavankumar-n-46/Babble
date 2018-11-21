//
//  UserDataService.swift
//  Babble
//
//  Created by Pavan Kumar N on 21/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    func setUserData(id: String, name: String, email: String, avatarName:String, color: String){
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.id = id
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
}
