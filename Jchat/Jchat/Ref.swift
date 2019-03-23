//
//  Ref.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/16/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Firebase

let REF_USER = "users"
let URL_STORAGE_ROOT = "gs://jchat-cc6b0.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"
let ERROR_EMPTY_PHOTO = "Please select an image"
let ERROR_EMPTY_EMAIL = "Please add your email address"
let ERROR_EMPTY_USERNAME = "Please enter your full name"
let ERROR_EMPTY_PASSWORD = "Please add a password"
let ERROR_EMPTY_EMAIL_RESET_PASSWORD = "Please add your email address to reset your password"
let SUCCESS_EMAIL_RESET = "We just sent you a password reset email. Please check your email and follow the instructions to reset your password."
let IDENTIFIER_TABBAR = "TabBarVC"
let IDENTIFIER_WELCOME = "WelcomeVC"


class Ref {
    
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    
    func databaseSpecificProfile(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //Storage Ref
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    
    func storageSpecifiProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }
}
