//
//  History.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/5/22.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    let exercise: [WorkoutTemplate.ExerciseData]
    
    init(id: UUID = UUID(), date: Date = Date(), exercise: [WorkoutTemplate.ExerciseData]) {
        self.id = id
        self.date = date
        self.exercise = exercise
    }
}
