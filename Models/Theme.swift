//
//  Theme.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

enum Theme: String {
    case navy
    case seafoam
    case lavender
    
    var accentColor: Color {
        switch self {
        case .navy, .lavender: return .white
        case .seafoam: return .black
        }
    }
    
    var mainColor : Color {
        Color(rawValue)
    }
}
