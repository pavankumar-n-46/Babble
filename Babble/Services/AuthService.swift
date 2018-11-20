//
//  AuthService.swift
//  Babble
//
//  Created by Pavan Kumar N on 20/11/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
    ///Singleton class.
    static let instance = AuthService()
    
    ///creating the user defaults to store persistent data.
    let defaults = UserDefaults.standard
    
    ///persistent var used to check whether the user is already logged in or not.
    var isLoggedIn : Bool{
        get{
            return defaults.bool(forKey:LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    ///persistent var used to get and set the authToken.
    var authToken : String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    ///persistent var used to get and set the user email.
    var userEmail : String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    /// initiates the request to create a new user.
    ///
    /// - Parameters:
    ///   - email: email of the new user.
    ///   - password: password of the new user.
    ///   - completion: completionhandler block which says either request is completed or failed.
    func registerUser(email: String, password: String, completion: @escaping completionHandler){
        
        /// converting the email into lower-case.
        let lowerCasedEmail = email.lowercased()
        
        /// builds the header of the request.
        let header = [
            "Content-type" : "application/json; charset=utf-8"
        ]
        
        /// builds the body of the request.
        let body : [String:Any] = [
            "email" : lowerCasedEmail,
            "password" : password
        ]
        
        ///Alamofire request which sends the request to create a new user and gives the corresponding response.
        request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

}

