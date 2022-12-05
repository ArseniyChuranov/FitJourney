//
//  EditExerciseCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/3/22.
//

import SwiftUI

struct EditExerciseCardView: View {
    
    var workout: WorkoutTemplate.ExerciseData

    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseCardView(workout: WorkoutTemplate.sampleData[0].exercise[0])
            .background()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
