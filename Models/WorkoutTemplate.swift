//
//  WorkoutTemplate.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import Foundation

struct WorkoutTemplate: Identifiable {
    var id: UUID
    var title: String
    var exercise: [Exercise]
    var exerciseValue: [Double]
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, exercise: [String : Double], exerciseValue: [Double], theme: Theme) {
        self.id = id
        self.title = title
        self.exercise = exercise.map { Exercise(name: $0, value: $1) }
        self.exerciseValue = exerciseValue
        self.theme = theme
    }
}

extension WorkoutTemplate {
    struct Exercise: Identifiable {
        let id: UUID
        var name: String
        var value: Double
        
        init(id: UUID = UUID(), name: String, value: Double) {
            self.id = id
            self.name = name
            self.value = value
        }
    }
}

/*

extension WorkoutTemplate {
    struct ExerciseValue: Identifiable {
        let id: UUID
        var value: Double
        
        init(id: UUID = UUID(), value: Double) {
            self.id = id
            self.value = value
        }
    }
}
 
*/

extension WorkoutTemplate {
    static let sampleData: [WorkoutTemplate] =
    [
        WorkoutTemplate(title: "Push", exercise: ["Bench press": 140.0, "Military Press" : 100.0, "Pushups" : 10 , "Shoulder Press" : 35.0], exerciseValue: [140.0, 100.0, 10, 35.0 ], theme: .seafoam),
        WorkoutTemplate(title: "Pull", exercise: ["Deadlift" : 200.0, "Pullups" : 5, "Cable Triceps Curl" : 30.0], exerciseValue: [200.0, 5.0, 30.0], theme: .lavender),
        WorkoutTemplate(title: "Legs", exercise: ["Squats" : 150.0, "Romanian Deadlift" : 100.0, "Quad Curls" : 80.0 , "Calve Raises" : 25.0], exerciseValue: [150.0, 100.0, 80.0, 25.0], theme: .navy)
    
    ]
}
