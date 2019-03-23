//
//  MessageApi.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class MessageApi {
    
    
    func sendMessage(from: String, to: String, value: Dictionary<String, Any>) {
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.childByAutoId().updateChildValues(value)
    }
}
