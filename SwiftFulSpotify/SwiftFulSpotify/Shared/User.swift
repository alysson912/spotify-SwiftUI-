//
//  UsersModel.swift
//  SwiftFulSpotify
//
//  Created by ALYSSON MENEZES on 25/06/25.
//

import Foundation


// MARK: - Welcome
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
            User(
                id: 444,
                firstName: "Alysson",
                lastName: "Dodo",
                age: 76,
                email: "hi@hi.com",
                phone: "",
                username: "",
                password: "",
                image: Constants.randomImage,
                height: 180,
                weight: 200
            )
        }
}

