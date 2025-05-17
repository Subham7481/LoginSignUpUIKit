//
//  CoreDataManager.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 16/05/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    // Access Core Data stack
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext

    // MARK: - Register User
    func registerUser(name: String ,email: String, password: String, age: Int16) {
        // Check if user already exists
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                print("❗️User already exists.")
                return
            }

            // Create new user
            let newUser = UserEntity(context: context)
            newUser.name = name
            newUser.email = email
            newUser.password = password  // ⚠️ Plain text for demo only
            newUser.age = age
            
            try context.save()
            print("✅ User registered successfully!")
        } catch {
            print("❌ Signup error: \(error.localizedDescription)")
        }
    }

    // MARK: - Authenticate User
    func authenticateUser(email: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

        do {
            let users = try context.fetch(fetchRequest)
            if users.isEmpty {
                print("❌ Invalid credentials")
                return false
            } else {
                print("✅ Login successful")
                return true
            }
        } catch {
            print("❌ Authentication failed: \(error)")
            return false
        }
    }
}

