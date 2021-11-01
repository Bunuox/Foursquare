//
//  User.swift
//  FoursquareWithParse
//
//  Created by Bünyamin Kılıçer on 1.11.2021.
//

import Foundation
import Parse

class User{
    
    func userLogOut(completion: @escaping (_ message:String) -> Void){
        PFUser.logOutInBackground { err in
            if err != nil {
                completion(err?.localizedDescription ?? "Something happened")
            }else{
                completion("Success")
            }
        }
    }
}
