//
//  UserDefaults.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 10.03.2022.
//

import Foundation

class AppSettings {
    
    static let shared = AppSettings()
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    private enum SettingsKeys: String {
        case appTheme = "AppTheme"
        case language = "Language"
        case user = "User"
        case isSignIn = "IsSignIn"
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
            guard let data = userDefaults.string(forKey: SettingsKeys.language.rawValue) else { return "" }
            return data
        }
        set {
            if newValue != "" {
                userDefaults.set(newValue, forKey: SettingsKeys.language.rawValue)
            }
        }
    }
    
    var user: User? {
        get {
            guard let data = userDefaults.value(forKey: SettingsKeys.user.rawValue) as? Data else { return nil }
            return try? PropertyListDecoder().decode(User.self, from: data)
        }
        
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else {
                userDefaults.set(nil, forKey: SettingsKeys.user.rawValue)
                signedIn = false
                return
            }
            userDefaults.set(data, forKey: SettingsKeys.user.rawValue)
            signedIn = true
        }
    }
}
