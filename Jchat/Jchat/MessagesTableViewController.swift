//
//  MessagesTableViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        observeInbox()
    }
    
    func observeInbox() {
        Api.Inbox.lastMessages(uid: Api.User.currentUserId)
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
   

    @IBAction func logoutBarButtonPressed(_ sender: UIBarButtonItem) {
        
        Api.User.logOut()
        
    }
    
}
