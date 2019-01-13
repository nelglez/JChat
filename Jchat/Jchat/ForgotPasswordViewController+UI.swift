//
//  ForgotPasswordViewController+UI.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

extension ForgotPasswordViewController {
    
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
    func setupForgotPasswordButton() {
        
        resetMyPasswordButton.setTitle("RESET MY PASSWORD", for: .normal)
        resetMyPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        resetMyPasswordButton.backgroundColor = UIColor.black
        resetMyPasswordButton.layer.cornerRadius = 5
        resetMyPasswordButton.clipsToBounds = true
        resetMyPasswordButton.setTitleColor(.white, for: .normal)
    }
    
}
