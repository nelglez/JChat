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
        
        var dict = value
        if let text = dict["text"] as? String, text.isEmpty {
            dict["imageUrl"] = nil
            dict["height"] = nil
            dict["width"] = nil
        }
        
        let refFrom = Ref().databaseInboxInFor(from: from, to: to)
        refFrom.updateChildValues(dict)
        
        let refTo = Ref().databaseInboxInFor(from: to, to: from)
        refTo.updateChildValues(dict)
    }
    
    func receiveMessage(from: String, to: String, onSuccess: @escaping(Message) -> Void) {
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key){
                onSuccess(message)
                }
            }
        }
    }
}
