//
//  ProfileTableViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 6/12/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var statusTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        observeData()
       
    }
    
    private func setupViews() {
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
    }
    
    private func observeData() {
        Api.User.getUserInfoFor(uid: Api.User.currentUserId) { (user) in
            self.usernameTextField.text = user.username
            self.emailTextField.text = user.email
            self.statusTextField.text = user.status
            self.avatar.loadImage(user.profileImageUrl)
        }
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}
