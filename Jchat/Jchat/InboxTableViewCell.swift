//
//  InboxTableViewCell.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 6/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var user: User!
    
    func configureCell(uid: String, inbox: Inbox) {
        self.user = inbox.user
        avatar.loadImage(inbox.user.profileImageUrl)
        usernameLabel.text = inbox.user.username
    
        let date = Date(timeIntervalSince1970: inbox.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        
        dateLabel.text = dateString
        
        if !inbox.text.isEmpty {
            messageLabel.text = inbox.text
        } else {
            messageLabel.text = "[MEDIA]"
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
