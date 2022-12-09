//
//  Theme.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//


// Figure a purpose for themes, and make sure i specify cases for them. Color could work well for morning/day/evening/night cases, as well as other purposes.


import SwiftUI

enum Theme: String, Codable {
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
