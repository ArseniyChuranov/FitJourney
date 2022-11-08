//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    let workout: WorkoutTemplate
    
    var body: some View {
        List {
            Section(header: Text("Workout Info")) {
                ForEach(workout.exercise) { exercise in
                    HStack {
                        Label(exercise.name, systemImage: "dumbbell")
                        Spacer()
                        Text(String(exercise.value))
                    }
                }
            }
        }
        .toolbar {
            Button (action: {}) {
                Image(systemName: "plus")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(workout: WorkoutTemplate.sampleData[0])
        }
    }
}
