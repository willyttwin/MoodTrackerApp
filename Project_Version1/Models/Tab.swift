//
//  Tab.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case home = "Home"
    case stats = "Stats"
    case calendar = "Calendar"
    case settings = "Settings"
    
    
    var systemImage: String{
        switch self {
        case .home:
            return "home"
        case .stats:
            return "stats"
        case .calendar:
            return "calendar"
        case .settings:
            return "settings"
        }
    }
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

