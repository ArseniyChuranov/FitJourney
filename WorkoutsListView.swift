//
//  WorkoutsListView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct WorkoutsListView: View {
    let workouts: [WorkoutTemplate]
    
    var body: some View {
        List {
            ForEach(workouts) { workout in
                NavigationLink(destination: DetailView(workout: workout)) {
                    CardView(workout: workout)
                }
                .listRowBackground(workout.theme.mainColor)
                .padding(.leading) // optional
            }
        }
        .navigationTitle("Workout")
        .toolbar {
            Button (action: {}) {
                Image(systemName: "plus")
            }
        }
    }
}

struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsListView(workouts: WorkoutTemplate.sampleData)
        }
    }
}
