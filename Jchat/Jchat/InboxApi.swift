//
//  InboxApi.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 6/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

typealias InboxCompletion = (Inbox) -> Void

class InboxApi {

    func lastMessages(uid: String, onSuccess: @escaping(InboxCompletion)) {
        let ref = Ref().databaseInboxForUser(uid: uid)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                Api.User.getUserInfoFor(uid: snapshot.key, onSuccess: { (user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user) {
                    onSuccess(inbox)
                    }
                })
            }
        }
    }
}
