//
//  StorageService.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/16/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD

class StorageService {
    static func savePhoto(username: String, uid: String, data: Data, metaData: StorageMetadata, storageProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileRef.putData(data, metadata: metaData, completion: { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileRef.downloadURL(completion: { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges(completion: { (error) in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        })
                    }
                  
                    var dicTemp = dict
                    dicTemp[PROFILE_IMAGE_URL] = metaImageUrl
                    
                    Ref().databaseSpecificProfile(uid: uid).updateChildValues(dicTemp, withCompletionBlock: { (error, ref) in
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
    
    
    static func savePhotoMessage(image: UIImage?, id: String, onSuccess: @escaping(_ value: Any) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        if let imagePhoto = image {
            let ref = Ref().storageSpecificImageMessage(id: id)
            if let data = imagePhoto.jpegData(compressionQuality: 0.5) {
                ref.putData(data, metadata: nil) { (metaData, error) in
                    if error != nil {
                        onError(error!.localizedDescription)
                    }
                    ref.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString  {
                            let dict: Dictionary<String, Any> = ["imageUrl" : metaImageUrl as Any, "height": imagePhoto.size.height as Any, "width" : imagePhoto.size.width as Any, "text" : "" as Any]
                            onSuccess(dict)
                        }
                        
                    })
                }
            }
        }
    }
}
