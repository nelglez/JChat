//
//  SignUpViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var fullNameContainerView: UIView!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordContainerView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var image: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
      
    }
    

    func setupUI() {
        setupTitleLabel()
        setupAvatar()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let imageSelected = self.image else {
            print("Avatar is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {return}
        
        Auth.auth().createUser(withEmail: "testing3@test.com", password: "123456") { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let result = result {
                print(result.user.email)
                var dict: Dictionary<String, Any> = ["uid": result.user.uid, "Email": result.user.email, "profileImageUrl": "", "status": "Welcome to Jchat" ]
                
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
                                    print("Done")
                                }
                            })
                        }
                    })
                })
                
            }
        }
    }
    
    

}
