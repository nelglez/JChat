//
//  UserApi.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/16/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import ProgressHUD

class UserApi {
    
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    
    func signUp(withUserName username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let result = result {
              
                let dict: Dictionary<String, Any> = [UID: result.user.uid, EMAIL: result.user.email, USERNAME: username, PROFILE_IMAGE_URL: "", STATUS: "Welcome to Jchat" ]
                
                guard let imageSelected = image else {
                    
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {return}
                
                let storageProfile = Ref().storageSpecifiProfile(uid: result.user.uid)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                StorageService.savePhoto(username: username, uid: result.user.uid, data: imageData, metaData: metaData, storageProfileRef: storageProfile, dict: dict, onSuccess: {
                    onSuccess()
                }, onError: { (errorMessage) in
                    onError(errorMessage)
                })
                
              
                
            }
        }
    }
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                
                onError(error!.localizedDescription)
                return
            }
            print("USER ID ***********", result?.user.uid)
            onSuccess()
            
        }
    }
    
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            ProgressHUD.showError(error.localizedDescription)
            return
        }
        
        (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
    }
    
    func observeUsers(onSuccess: @escaping(UserCompletion)) {
        Ref().databaseUsers.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    onSuccess(user)
                }
                
            }
        }
    }
}

typealias UserCompletion = (User) -> Void
