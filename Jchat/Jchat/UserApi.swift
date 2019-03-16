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
    func signUp(withUserName username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let result = result {
              
                var dict: Dictionary<String, Any> = ["uid": result.user.uid, "Email": result.user.email, "username": username, "profileImageUrl": "", "status": "Welcome to Jchat" ]
                
                guard let imageSelected = image else {
                    
                    ProgressHUD.showError("Please select an image")
                    return
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {return}
                
                let storageRef = Storage.storage().reference(forURL: "gs://jchat-cc6b0.appspot.com")
                
                let storageProfileImageRef = storageRef.child("profile").child(result.user.uid)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                storageProfileImageRef.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    storageProfileImageRef.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            print(metaImageUrl)
                            dict["profileImageUrl"] = metaImageUrl
                            
                            Database.database().reference().child("users").child(result.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                                if error == nil {
                                    onSuccess()
                                } else {
                                    onError(error!.localizedDescription)
                                }
                            })
                        }
                    })
                })
                
            }
        }
    }
}
