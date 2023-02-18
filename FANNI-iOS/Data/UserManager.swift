//
//  UserManager.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/15.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }
}

final class UserManager {
    
    @UserDefault(key: "snsID", defaultValue: "")
    static var snsID: String
    
    @UserDefault(key: "snsType", defaultValue: "")
    static var snsType: String
    
    @UserDefault(key: "nickName", defaultValue: "")
    static var nickName: String
    
    @UserDefault(key: "email", defaultValue: "")
    static var email: String
    
    @UserDefault(key: "birthday", defaultValue: "")
    static var birthday: String
}
