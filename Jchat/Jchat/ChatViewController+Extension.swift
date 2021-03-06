//
//  ChatViewController+Extension.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import  UIKit

extension ChatViewController {
    func observeMessages() {
        Api.Message.receiveMessage(from: Api.User.currentUserId, to: partnerId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
        Api.Message.receiveMessage(from: partnerId, to: Api.User.currentUserId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
    }
    
    func sortMessages() {
        messages = messages.sorted(by: {$0.date < $1.date })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupPicker() {
        picker.delegate = self
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
 //       avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containerView.addSubview(avatarImageView)
        
        if imagePartner != nil {
            avatarImageView.image = imagePartner
            observeMessages()
        } else {
            avatarImageView.loadImage(partnerUser.profileImageUrl) { (image) in
                self.imagePartner = image
                self.observeMessages()
            }
        }
        
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
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func sendToFirebase(dict: Dictionary<String, Any>) {
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        Api.Message.sendMessage(from: Api.User.currentUserId, to: partnerId, value: value)

        if let videoUrl = dict["videoUrl"] as? String, !videoUrl.isEmpty {
            //Send Video Notification
            handleNotification(fromUid: Api.User.currentUserId, message: "[VIDEO]")
        } else if let imageUrl = dict["imageUrl"] as? String, !imageUrl.isEmpty {
            //Send image notification
            handleNotification(fromUid: Api.User.currentUserId, message: "[PHOTO]")
        } else if let text = dict["text"] as? String, !text.isEmpty {
            //Send text notification
            handleNotification(fromUid: Api.User.currentUserId, message: text)
        }

    }
    
    func handleNotification(fromUid: String, message: String) {
        Api.User.getUserInfoForSingleEvent(uid: fromUid) { (user) in
            sendRequestNotification(fromUser: user, toUser: self.partnerUser, message: message, badge: 1)
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


extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[.mediaURL] as? URL {
            handleVideoSelectedForUrl(videoUrl)
        } else {
            handelImageSelectedForInfo(info)
        }
    }
    
    func handleVideoSelectedForUrl(_ url: URL) {
        //save video data
        let videoName = NSUUID().uuidString
        StorageService.saveVideoMessages(url: url, id: videoName, onSuccess: { (anyValue) in
            if let dict = anyValue as? [String: Any] {
                self.sendToFirebase(dict: dict)
            }
        }) { (error) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func handelImageSelectedForInfo(_ info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = imageSelected
        }
        if let imageSelectedOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = imageSelectedOriginal
            
        }
        //save photo data
        let imageName = NSUUID().uuidString
        StorageService.savePhotoMessage(image: selectedImageFromPicker, id: imageName, onSuccess: { (anyValue) in
            if let dict = anyValue as? [String: Any] {
                self.sendToFirebase(dict: dict)
            }
        }) { (error) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        //play button should only appear in video messages.
        cell.playButton.isHidden = messages[indexPath.row].videoUrl == ""
        
        cell.configureCell(uid: Api.User.currentUserId, message: messages[indexPath.row], image: imagePartner)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let message = messages[indexPath.row]
        let text = message.text
        if !text.isEmpty {
            height = text.estimateFrameForText(text).height + 60
        }
        
        let heightMessage = message.height
        let widthMessage = message.width
        
        if heightMessage != 0, widthMessage != 0 {
            height = CGFloat(heightMessage / widthMessage * 250)
        }
        return height
    }
    
    
}
