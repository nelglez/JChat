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
import ProgressHUD

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
         self.view.endEditing(true)
        self.validateFields()
        self.signUp(onSuccess: {
            //switch View
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
        
        
      
    }
    
    

}
