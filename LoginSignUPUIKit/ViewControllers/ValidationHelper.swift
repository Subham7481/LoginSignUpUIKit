//
//  ValidationHelper.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 16/05/25.
//

import Foundation
struct ValidationHelper{
    static func validateFields(fields: [String?]) -> String? {
        for field in fields{
            if field?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                return "Please fill all the fields."
            }
        }
        return nil
    }
}
