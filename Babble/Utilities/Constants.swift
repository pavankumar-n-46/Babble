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

//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
