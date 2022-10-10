//
//  UserDefaults.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 10.03.2022.
//

import Foundation

protocol AppSettingsProtolol {
    var appTheme: Int { get set }
}

class AppSettings: AppSettingsProtolol {
    
    static let shared = AppSettings()
    private let userDefaults = UserDefaults.standard
    
    private enum SettingsKeys: String {
        case appTheme = "AppTheme"
    }
    
    private init() { }
    
    var appTheme: Int {
        get { return userDefaults.integer(forKey: SettingsKeys.appTheme.rawValue) }
        set { userDefaults.set(newValue, forKey: SettingsKeys.appTheme.rawValue) }
    }
}
