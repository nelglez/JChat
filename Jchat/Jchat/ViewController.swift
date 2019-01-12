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
        
        setupHeaderTitle()
        setupOrLabel()
        setupTermsLabel()
        setupSignInWithFacebookButton()
        setupSignInWithGoogleButton()
        setupSignInWithEmailButton()
    }


}

