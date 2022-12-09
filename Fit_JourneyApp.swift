//
//  Fit_JourneyApp.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

@main
struct Fit_JourneyApp: App {
    @State private var workouts = WorkoutTemplate.sampleData
    @StateObject private var store = WorkoutStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsListView(workouts: $store.workouts) {
                    WorkoutStore.save(workouts: store.workouts) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                WorkoutStore.load {result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let workouts):
                        store.workouts = workouts
                    }
                }
            }
        }
    }
}
