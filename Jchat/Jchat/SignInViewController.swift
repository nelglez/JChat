//
//  SignInViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class SignInViewController: UIViewController {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordContainerView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    
    func setupUI() {
        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupSignUpButton()
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.validateFields()
        self.signIn(onSuccess: {
            //switch view
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
}
