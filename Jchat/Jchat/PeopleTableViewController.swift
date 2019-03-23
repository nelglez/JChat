//
//  PeopleTableViewController.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 3/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var users: [User] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var searchResults: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarController()
        setupNavigationBar()
        setupTableView()
        
        observeUsers()

    }
    
    func setupSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
       searchController.searchBar.placeholder = "Search users..."
       searchController.searchBar.barTintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setupNavigationBar() {
        navigationItem.title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty {
            view.endEditing(true)
        } else {
            let textLowercased = searchController.searchBar.text!.lowercased()
            filterContent(for: textLowercased)
        }
        tableView.reloadData()
    }
    
    func  filterContent(for searchText: String) {
        
        searchResults = self.users.filter {
            return $0.username.lowercased().range(of: searchText) != nil
        }
    }
    
    func observeUsers() {
        Api.User.observeUsers { (user) in
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return searchController.isActive ? searchResults.count : self.users.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_USERS, for: indexPath) as! UserTableViewCell

        let user = searchController.isActive ?  searchResults[indexPath.row] : users[indexPath.row]
        
        cell.loadData(user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell {
            
            let storyBoard = UIStoryboard(name: "Welcome", bundle: nil)
            
               let chatVC = storyBoard.instantiateViewController(withIdentifier: IDENTIFIER_CHAT) as! ChatViewController
            
            chatVC.imagePartner = cell.avatar.image
            chatVC.partnerUsername = cell.usernameLabel.text
            
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }

}
