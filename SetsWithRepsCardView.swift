//
//  SetsWithRepsCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/29/22.
//

import SwiftUI

struct SetsWithRepsCardView: View {
    let exerciseSets: WorkoutTemplate.ExerciseSet
    @State private var sets = WorkoutTemplate.Sets()

    
    
    var body: some View {
        HStack {
            Text("Set")
            Spacer()
            Text("Reps: \(exerciseSets.reps)")
            Spacer()
            Text("Weight: \(exerciseSets.weight)")
        }
       // .padding()
    }
}

struct SetsWithRepsCardView_Previews: PreviewProvider {
    static var exerciseSets = WorkoutTemplate.ExerciseSet(sets: 1, reps: 1, weight: 10)
    static var previews: some View {
        SetsWithRepsCardView(exerciseSets: WorkoutTemplate.sampleData[0].exercise[0].exerciseSets[0])
    }
}
