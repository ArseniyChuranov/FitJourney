//
//  NewExerciseEdit.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/8/22.
//
// 
//

import SwiftUI

struct NewExerciseEdit: View {
    
    @Binding var data: WorkoutTemplate.Data // if thats a new exercise should it be Binding?
    // @Binding var exercise: WorkoutTemplate.ExerciseData
    
    @State private var newExerciseName = ""
    // @State private var newExerciseValue = 0.0
    @State private var newExerciseSetsValue = ""
    @State private var newExerciseRepsValue = ""
    @State private var newExerciseWeightValue = ""
    
    @State private var isShowingSetView = false
    
    var body: some View {
        Form {
            Section(header: Text("New Workout")) {
                TextField("Workout title", text: $data.title)
                    .font(.title)
                // for new view present one empty instance with a possibility to add more
                
                ForEach(data.exercise) {exercise in
                    Text(exercise.workoutName)
                    // Text(String(exercise.exerciseSets[0].weight)) // thats the way to get info out of the list!!!
                }
                .onDelete {indices in
                    data.exercise.remove(atOffsets: indices)
                }
            
                HStack {
                    TextField("New Exercise", text: $newExerciseName)
                    Button (action: {
                        
                        // create a color picker
                        
                        let newExercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName, exerciseSets: []) // sets will be empty for now, since we are creating only a workout
                        data.exercise.append(newExercise)
                        newExerciseName = ""
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newExerciseName.isEmpty)
                }
                
                
                /*
                 
                 
                
                ForEach(data.exercise) { title in
                    VStack {
                        HStack {
                            TextField("New Exercise", text: $newExerciseName)
                            Button (action: {
                                withAnimation {
                                    let exercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName,
                                                                                exerciseSets: [WorkoutTemplate.ExerciseSet(sets: 1, reps: 1, weight: 1)]) // should be added later with other inputs.
                                    data.exercise.append(exercise)

                                }
                            }) {
                                Image(systemName: "plus")
                            }
                            .disabled(newExerciseName.isEmpty)
                        }
                        Spacer()
                        HStack {
                            TextField("Sets", text: $newExerciseSetsValue)
                            Spacer()
                            TextField("Reps", text: $newExerciseRepsValue)
                        }
                    }
                    // fill the rest with other stuff
                }
                .onDelete { indices in
                    data.exercise.remove(atOffsets: indices)
                }
                
                */
            }
        }
    }
}

struct NewExerciseEdit_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewExerciseEdit(data: .constant(WorkoutTemplate.sampleData[0].data))
            
            NewExerciseEdit(data: .constant(WorkoutTemplate.sampleData[0].data))
                .environment(\.colorScheme, .dark)
        }
    }
}
