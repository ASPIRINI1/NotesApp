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
            return NSLocalizedString("System", comment: "")
        case .light:
            return NSLocalizedString("Light", comment: "")
        case .dark:
            return NSLocalizedString("Dark", comment: "")
        @unknown default:
            return ""
        }
    }
}
