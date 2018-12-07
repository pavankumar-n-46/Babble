//
//  Constants.swift
//  Babble
//
//  Created by Pavan Kumar N on 19/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import Foundation

typealias completionHandler = (_ success:Bool) -> ()

//URL Constants
let BASE_URL = "https://babble4babble.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"

//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//headers
let HEADER = [ "Content-type" : "application/json; charset=utf-8" ]
let HEADER_AUTH = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-type" : "application/json; charset=utf-8"
]


//notificaiton center
let NOTIF_USER_DID_CHANGE = Notification.Name("notifUserDataChanged")
