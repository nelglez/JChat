//
//  ViewController+UI.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

extension ViewController {
    func setupHeaderTitle() {
        let title = "Create a new account"
        let subTitle = "\n\n Some text here..."
        
        //if you need formatting or inner activity you  need to use NSMutableAttributedString
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font : UIFont(name: "Didot", size: 28)!, .foregroundColor : UIColor.brown])
        
        let attributedSubTitle = NSMutableAttributedString(string: subTitle, attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor(white: 0, alpha: 0.45)])
        
        attributedText.append(attributedSubTitle)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        titleLabel.numberOfLines = 0
        
        titleLabel.attributedText = attributedText
    }
    
    func setupOrLabel() {
        orLabel.text = "Or"
        orLabel.font = UIFont.boldSystemFont(ofSize: 16)
        orLabel.textColor = UIColor(white: 0, alpha: 0.45)
        orLabel.textAlignment = .center
    }
    
    func setupTermsLabel(){
        let termsOfServiceText = NSMutableAttributedString(string: """
        By clicking "Create and Account" you agree to our \n
        """, attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        let termsOfServiceSubText = NSMutableAttributedString(string: "Terms of Service", attributes: [.font : UIFont.boldSystemFont(ofSize: 14), .foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        termsOfServiceText.append(termsOfServiceSubText)
        
        termsOfServiceLabel.attributedText = termsOfServiceText
        termsOfServiceLabel.numberOfLines = 0
    }
    
    func setupSignInWithFacebookButton() {
        signInWithFacebook.setTitle("Sign in with Facebook", for: .normal)
        signInWithFacebook.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInWithFacebook.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        signInWithFacebook.layer.cornerRadius = 5
        signInWithFacebook.clipsToBounds = true
        
        signInWithFacebook.setImage(UIImage(named: "facebook"), for: .normal)
        signInWithFacebook.imageView?.contentMode = .scaleAspectFit
        signInWithFacebook.tintColor = .white
        //shrink the image
        signInWithFacebook.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
    }
    
    func setupSignInWithGoogleButton() {
        signInWithGoogle.setTitle("Sign in with Google", for: .normal)
        signInWithGoogle.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInWithGoogle.backgroundColor = UIColor(red: 223/255, green: 74/255, blue: 50/255, alpha: 1)
        signInWithGoogle.layer.cornerRadius = 5
        signInWithGoogle.clipsToBounds = true
        
        signInWithGoogle.setImage(UIImage(named: "google"), for: .normal)
        signInWithGoogle.imageView?.contentMode = .scaleAspectFit
        signInWithGoogle.tintColor = .white
        //shrink the image
        signInWithGoogle.imageEdgeInsets = UIEdgeInsets(top: 12, left: -35, bottom: 12, right: 0)
    }
    
    func setupSignInWithEmailButton(){
        createAnAccountButton.setTitle("Create a new account", for: .normal)
        createAnAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAnAccountButton.backgroundColor = UIColor.black
        createAnAccountButton.layer.cornerRadius = 5
        createAnAccountButton.clipsToBounds = true
    }
}
