//
//  ExerciseCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/28/22.
//

import SwiftUI

struct ExerciseCardView: View {
    let workout: WorkoutTemplate
    let exercise: WorkoutTemplate.ExerciseData
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Bench Press")
                    .font(.title2)
            }
            
            // draw a cell and system i want to use
            
            Spacer()
                .frame(height: 10) // check for better possible solution
            HStack {
                Text("Sets:")
                Text(String(exercise.sets!))
                Spacer()
                Text("Reps:")
                Text(String(exercise.reps!))
            }
            
            
        }
        .padding()
    }
}

struct ExerciseCardView_Previews: PreviewProvider {
    static var workout = WorkoutTemplate.sampleData[0]
    static var exercise = WorkoutTemplate.ExerciseData.init(workoutName: "Bench Press", sets: 3, reps: 6, weight: 100)
    static var previews: some View {
        ExerciseCardView(workout: workout, exercise: exercise)
            .background(.yellow)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}



/*
 
 VStack(alignment: .leading) {
     HStack {
         Text(exercise.workoutName)
             .font(.title2)
         Spacer()
         Text("Weight:")
         Text(String(exercise.weight!))
     }
     Spacer()
         .frame(height: 10) // check for better possible solution
     HStack {
         Text("Sets:")
         Text(String(exercise.sets!))
         Spacer()
         Text("Reps:")
         Text(String(exercise.reps!))
     }
     
     
 }
 .padding()
 
 */
