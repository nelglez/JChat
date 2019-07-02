//
//  ChatViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ChatViewController: UIViewController {
    
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
   
    
    
    var imagePartner: UIImage!
    var partnerUsername: String!
    var partnerId: String!
    var partnerUser: User!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var placeHolderLabel = UILabel()
    
    var picker = UIImagePickerController()
    
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInputContainer()
        setupNavigationBar()
        setupTableView()
        setupPicker()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
 
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let text = inputTextView.text, text != "" {
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict: ["text" : text as Any])
            
        }
    }
    @IBAction func mediaButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "JChat", message: "Select Source", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Take a picture", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
            } else {
                //alert the user
            }
        }
        
        let library = UIAlertAction(title: "Choose an Image or a Video", style: .default) { (_) in
             if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
            self.present(self.picker, animated: true, completion: nil)
             } else {
                //alert the user
            }
        }
        
        let videoCamera = UIAlertAction(title: "Take a Video", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.sourceType = .camera
                self.picker.mediaTypes = [String(kUTTypeMovie)]
                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                self.picker.videoMaximumDuration = 30
                self.present(self.picker, animated: true, completion: nil)
            } else {
                //alert the user
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(videoCamera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}



