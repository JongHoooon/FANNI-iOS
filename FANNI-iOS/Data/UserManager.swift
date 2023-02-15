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
    
    @UserDefault(key: "kakaoID", defaultValue: 0)
    static var kakaoID: Int
    
    @UserDefault(key: "kakaoNickname", defaultValue: "")
    static var kakaoNickname: String
    
    @UserDefault(key: "email", defaultValue: "")
    static var kakaoEmail: String
    
    @UserDefault(key: "birthday", defaultValue: "")
    static var birthday: String
}
