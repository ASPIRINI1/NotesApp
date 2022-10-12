//
//  UserInterfaceStyle+title.swift
//  NotesApp
//
//  Created by Станислав Зверьков on 20.09.2022.
//

import Foundation
import UIKit

extension UIUserInterfaceStyle: CaseIterable {
    public static var allCases: [UIUserInterfaceStyle] = [.unspecified, .light, .dark]
    var title: String {
        switch self {
        case .unspecified:
            return NSLocalizedString("System", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
        case .light:
            return NSLocalizedString("Light", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
        case .dark:
            return NSLocalizedString("Dark", tableName: LocalizeTableNames.Settings.rawValue, comment: "")
        @unknown default:
            return ""
        }
    }
}
