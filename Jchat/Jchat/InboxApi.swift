//
//  InboxApi.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 6/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

class InboxApi {

    func lastMessages(uid: String) {
        let ref = Ref().databaseInboxForUser(uid: uid)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                print(dict)
            }
        }
    }
}
