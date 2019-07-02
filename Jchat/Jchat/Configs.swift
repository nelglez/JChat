//
//  Configs.swift
//  Jchat
//
//  Created by Nelson Gonzalez on 7/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

let fcmUrl = "https://fcm.googleapis.com/fcm/send"
let serverKey = "AAAAGJcmMiI:APA91bHxNLdyX5iwNzMHJhYiOJGVWj3vjkJh5iyyaKdYqe8rW_OdEh9u5NbU0IwoJVX59kRUy7ekpFuRCi7iPE4pmg1UVEcZ2dJ4csEDlP9jKPGVKjVIS3BZqqoaKdH6dpNIm1TEnm97"

func sendRequestNotification(fromUser: User, toUser: User, message: String, badge: Int) {
    var request = URLRequest(url: URL(string: fcmUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
    
    request.httpMethod = "POST"
    
    let notification: [String: Any] = ["to" : "/topics/\(toUser.uid)", "notification" : ["title" : fromUser.username, "body" : message], "sound" : "default", "badge" : badge, "customData" : ["userId" : fromUser.uid, "username" : fromUser.username, "email" : fromUser.email, "profileImageUrl" : fromUser.profileImageUrl]]
    
    let data = try! JSONSerialization.data(withJSONObject: notification, options: [])
    request.httpBody = data
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else { return }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("HTTPUrlResponse \(httpResponse.statusCode)")
            print("Response: \(response)")
        }
        
        if let responseString = String(data: data, encoding: .utf8) {
            print("ResponseString \(responseString)")
        }
    }.resume()
    
}
