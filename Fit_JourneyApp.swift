//
//  Fit_JourneyApp.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

@main
struct Fit_JourneyApp: App {
    // @State private var workouts = WorkoutTemplate.sampleData
    @StateObject private var store = WorkoutStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsListView(workouts: store.workouts) {
                    Task {
                        do {
                            try await WorkoutStore.save(workouts: store.workouts)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.workouts = try await WorkoutStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Fit Journey will load sample data")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.workouts = WorkoutTemplate.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            .environmentObject(store)
        }
    }
}
