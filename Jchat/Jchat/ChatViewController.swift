//
//  ChatViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var imagePartner: UIImage!
    var partnerUsername: String!
    var partnerId: String!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var placeHolderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInputContainer()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containerView.addSubview(avatarImageView)
        
        let rightBarButton = UIBarButtonItem(customView: containerView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: partnerUsername + "\n", attributes: [.font : UIFont.systemFont(ofSize: 17), .foregroundColor : UIColor.black])
        
        attributed.append(NSAttributedString(string: "Active", attributes: [.font : UIFont.systemFont(ofSize: 13), .foregroundColor : UIColor.green]))
        
        topLabel.attributedText = attributed
        
        self.navigationItem.titleView = topLabel
    }
    
    func setupInputContainer() {
        let mediaImage = UIImage(named: "attachment")?.withRenderingMode(.alwaysTemplate)
        mediaButton.setImage(mediaImage, for: .normal)
        mediaButton.tintColor = .lightGray
        
        let micImage = UIImage(named: "mic")?.withRenderingMode(.alwaysTemplate)
        audioButton.setImage(micImage, for: .normal)
        audioButton.tintColor = .lightGray
        
        setupInputTextView()
    }
    
    func setupInputTextView() {
        
        inputTextView.delegate = self
        
        placeHolderLabel.isHidden = false
        
        let placeholderX: CGFloat = self.view.frame.size.width / 75
        let placeholderY: CGFloat = 0
        let placeholderWidth: CGFloat = inputTextView.bounds.width - placeholderX
        let placeholderHeight: CGFloat = inputTextView.bounds.height
        
        let placeholderFontSize = self.view.frame.size.width / 25
        
        placeHolderLabel.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderWidth, height: placeholderHeight)
        
        placeHolderLabel.text = "Write a message..."
        placeHolderLabel.font = UIFont(name: "HelveticaNeue", size: placeholderFontSize)
        placeHolderLabel.textColor = .lightGray
        placeHolderLabel.textAlignment = .left
        
        inputTextView.addSubview(placeHolderLabel)
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    func sendToFirebase(dict: Dictionary<String, Any>) {
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        Api.Message.sendMessage(from: Api.User.currentUserId, to: partnerId, value: value)
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let text = inputTextView.text, text != "" {
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict: ["text" : text as Any])
            
        }
    }
    
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty {
            let text = textView.text.trimmingCharacters(in: spacing)
            sendButton.isEnabled = true
            sendButton.setTitleColor(.black, for: .normal)
            placeHolderLabel.isHidden = true
        } else {
            sendButton.isEnabled = false
            sendButton.setTitleColor(.lightGray, for: .normal)
            placeHolderLabel.isHidden = false
        }
    }
}
