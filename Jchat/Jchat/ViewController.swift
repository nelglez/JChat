//
//  ViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInWithFacebook: UIButton!
    
    @IBOutlet weak var signInWithGoogle: UIButton!
    
    @IBOutlet weak var createAnAccountButton: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        let title = "Create a new account"
        let subTitle = "\n\n Some text here..."
        
        //if you need formatting or inner activity you  need to use NSMutableAttributedString
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont(name: "Didot", size: 28)!, NSAttributedString.Key.foregroundColor : UIColor.brown])
        
        let attributedSubTitle = NSMutableAttributedString(string: subTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.45)])
        
        attributedText.append(attributedSubTitle)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        titleLabel.numberOfLines = 0
        
        titleLabel.attributedText = attributedText
        
        
        orLabel.text = "Or"
        orLabel.font = UIFont.boldSystemFont(ofSize: 16)
        orLabel.textColor = UIColor(white: 0, alpha: 0.45)
        orLabel.textAlignment = .center
        
        
        let termsOfServiceText = NSMutableAttributedString(string: """
        By clicking "Create and Account" you agree to our \n
        """, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        let termsOfServiceSubText = NSMutableAttributedString(string: "Terms of Service", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)])
        
        termsOfServiceText.append(termsOfServiceSubText)
        
        termsOfServiceLabel.attributedText = termsOfServiceText
        termsOfServiceLabel.numberOfLines = 0
    }


}

