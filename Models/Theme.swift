//
//  Theme.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//


// Figure a purpose for themes, and make sure i specify cases for them. Color could work well for morning/day/evening/night cases, as well as other purposes.


import SwiftUI

enum Theme: String, CaseIterable, Codable, Identifiable {
    case navy
    case seafoam
    case lavender
    case buttercup
    case gray
    case green
    case indigo
    case mint
    case orange
    case pink
    case red
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .navy, .lavender, .buttercup, .gray, .green, .indigo, .orange, .pink, .red: return .white
        case .seafoam, .mint, .teal, .yellow: return .black
        }
    }
    
    var mainColor : Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
