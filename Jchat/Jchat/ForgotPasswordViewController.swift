//
//  ForgotPasswordViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 1/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetMyPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    
    func setupUI() {
        setupEmailTextField()
        setupForgotPasswordButton()
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
