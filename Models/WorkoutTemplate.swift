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
    var exercise: [String]
    var exerciseValue: [Double]
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, exercise: [String], exerciseValue: [Double], theme: Theme) {
        self.id = id
        self.title = title
        self.exercise = exercise
        self.exerciseValue = exerciseValue
        self.theme = theme
    }
}


extension WorkoutTemplate {
    static let sampleData: [WorkoutTemplate] =
    [
        WorkoutTemplate(title: "Push", exercise: ["Bench press", "Military Press", "Pushups", "Shoulder Press"], exerciseValue: [140.0, 100.0, 10, 35.0 ], theme: .seafoam),
        WorkoutTemplate(title: "Pull", exercise: ["Deadlift", "Pullups", "Cable Triceps Curl"], exerciseValue: [200.0, 5.0, 30.0], theme: .lavender),
        WorkoutTemplate(title: "Legs", exercise: ["Squats", "Romanian Deadlift", "Quad Curls", "Calve Raises"], exerciseValue: [150.0, 100.0, 80.0, 25.0], theme: .navy)
    
    ]
}
