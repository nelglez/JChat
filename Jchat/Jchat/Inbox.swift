//
//  Inbox.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 6/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class Inbox {
    var date: Double
    var text: String
    var user: User
    var read = false
    
    
    
    init(date: Double, text: String, user: User, read: Bool){
        self.date = date
        self.text = text
        self.user = user
        self.read = read
      
    }
    
    static func transformInbox(dict: [String: Any], user: User) -> Inbox? {
        guard let date = dict["date"] as? Double, let text = dict["text"] as? String, let read = dict["read"] as? Bool else {return nil}
        
        let inbox = Inbox(date: date, text: text, user: user, read: read)
        
        return inbox
    }
    
}
