//
//  UserDefaults.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 10.03.2022.
//

import Foundation

class AppSettings {
    
    static let shared = AppSettings()
    let userDefaults = UserDefaults.standard
    
    private init() {
        
    }
    
    private enum SettingsKeys: String {
        case appTheme = "AppTheme"
        case language = "Language"
        case user = "User"
        case isSignIn = "isSignIn"
    }
    
    var signedIn: Bool {
        get {
            return userDefaults.bool(forKey: SettingsKeys.isSignIn.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: SettingsKeys.isSignIn.rawValue)
        }
    }
    
    var appTheme: Int {
        get {
            return userDefaults.integer(forKey: SettingsKeys.appTheme.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: SettingsKeys.appTheme.rawValue)
        }
    }
    var language: String {
        get {
            if let data = userDefaults.string(forKey: SettingsKeys.language.rawValue){
                return data
            } else {
                return ""
            }
        }
        set {
            if newValue != "" {
                userDefaults.set(newValue, forKey: SettingsKeys.language.rawValue)
            }
        }
    }
    
    var user: User? {
        get {
            if let data = userDefaults.value(forKey: SettingsKeys.user.rawValue) as? Data {
              return try? PropertyListDecoder().decode(User.self, from: data)
            }
            return nil
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                userDefaults.set(data, forKey: SettingsKeys.user.rawValue)
            }
            
            if newValue != nil {
                signedIn = true
                
            } else {
                signedIn = false
            }
        }
    }
}
