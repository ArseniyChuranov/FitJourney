//
//  Fit_JourneyApp.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

@main
struct Fit_JourneyApp: App {
    
    // @StateObject private var store =
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsListView(workouts: WorkoutTemplate.sampleData)
            }
        }
    }
}
