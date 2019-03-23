//
//  SignInViewController+UI.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

extension SignInViewController {
    
    func setupTitleLabel() {
        let title = "Sign In"
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont(name: "Didot", size: 28)!, NSAttributedString.Key.foregroundColor : UIColor.brown])
        
        
        titleTextLabel.attributedText = attributedText
    }
    func setupEmailTextField() {
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        emailContainerView.layer.cornerRadius = 3
        emailContainerView.clipsToBounds = true
        
        emailTextField.borderStyle = .none
        
        let placeHolderAttributed = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        emailTextField.attributedPlaceholder = placeHolderAttributed
        emailTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    func setupPasswordTextField() {
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        
        passwordContainerView.layer.cornerRadius = 3
        passwordContainerView.clipsToBounds = true
        
        passwordTextField.borderStyle = .none
        
        let placeHolderAttributed = NSAttributedString(string: "Password (8+ Characters)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = placeHolderAttributed
        passwordTextField.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
    }
    func setupSignInButton() {
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = UIColor.black
        signInButton.layer.cornerRadius = 5
        signInButton.clipsToBounds = true
        signInButton.setTitleColor(.white, for: .normal)
    }
    func setupSignUpButton() {
        let attributedText = NSMutableAttributedString(string: "Don't have and account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        let attributedSubText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black])
        
        attributedText.append(attributedSubText)
        signUpButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func validateFields() {

        guard let email = self.emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
            
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
            
        }
    }
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        ProgressHUD.show("Loading...")
        
        Api.User.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!, onSuccess: {
            ProgressHUD.dismiss()
            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }
    
}
