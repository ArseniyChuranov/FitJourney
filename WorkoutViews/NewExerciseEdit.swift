//
//  NewExerciseEdit.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/8/22.
//
// 
//

import SwiftUI

enum textField: Hashable {
    case workoutName
    case exerciseName
    case defaultCase
}

struct NewExerciseEdit: View {
    
    @Binding var data: WorkoutTemplate.Data // if thats a new exercise should it be Binding?
    // @Binding var exercise: WorkoutTemplate.ExerciseData
    
    @State private var newExerciseName = ""
    @State private var newEditedExerciseName = ""
    // @State private var newExerciseValue = 0.0
    @State private var newExerciseSetsValue = ""
    @State private var newExerciseRepsValue = ""
    @State private var newExerciseWeightValue = ""
    @State private var isPresent = false
    
    @Binding var exercisesList: [String]
    @FocusState private var focused: textField?
    
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void

    
    @State private var isShowingSetView = false
    
    var body: some View {
        Form {
            Section(header: Text("New Workout")) {
                TextField("Workout title", text: $data.title)
                    .font(.title)
                    .onSubmit {
                        focused = .exerciseName
                    }
                // for new view present one empty instance with a possibility to add more
                ForEach(0..<exercisesList.count, id: \.self) {exercise in
                    TextField(exercisesList[exercise], text: $exercisesList[exercise])
                    // This method works pretty good, but if i will  change several exercises and then submit it, it will submit changes, see if i want to change it or not. I still assume that it is better to save shanges onDisappear
                        .onSubmit {
                            let updatedExercise = WorkoutTemplate.ExerciseData(workoutName: exercisesList[exercise], exerciseSets: [])
                            
                            data.exercise.insert(updatedExercise, at: exercise)
                            data.exercise.remove(at: exercise + 1)
                            
                        }
                        
                    
                        
                        //.disabled(exercisesList[exercise].isEmpty) // only protection method
                    // Text(String(exercise.exerciseSets[0].weight)) // thats the way to get info out of the list!!!
                }
                .onDelete {indices in
                    data.exercise.remove(atOffsets: indices)
                    exercisesList.remove(atOffsets: indices)
                }
 
            
                HStack {
                    TextField("New Exercise", text: $newExerciseName)
                        .onSubmit {
                            exercisesList.append(newExerciseName)
                            // create a color picker
                            
                            let newExercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName, exerciseSets: []) // sets will be empty for now, since we are creating only a workout
                            data.exercise.append(newExercise)
                            newExerciseName = ""
                            
                            focused = .exerciseName
                            
                        }
                        .focused($focused, equals: .exerciseName)
  
                    
                    Button (action: {
                        exercisesList.append(newExerciseName)
                        // create a color picker
                        
                        let newExercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName, exerciseSets: []) // sets will be empty for now, since we are creating only a workout
                        data.exercise.append(newExercise)
                        newExerciseName = ""
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newExerciseName.isEmpty)
                }
            }
            
            // it kinda works? not the most efficent way i assume. still need polish
            
            /*
             
             
             .onTapGesture {
                 focused = .none
             }
             .onChange(of: focused) {newAction in
                 var index = 0
                 for exerciseName in exercisesList {
                     if(exerciseName != data.exercise[index].workoutName) {
                         let updatedExercise = WorkoutTemplate.ExerciseData(workoutName: exercisesList[index], exerciseSets: [])
                         
                         data.exercise.insert(updatedExercise, at: index)
                         data.exercise.remove(at: index + 1)
                     }
                     
                     index = index + 1
                 }
             }
             
             
             */
        }
    }
}

struct NewExerciseEdit_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewExerciseEdit(data: .constant(WorkoutTemplate.sampleData[0].data), exercisesList: .constant([]), saveAction: {})
            
            NewExerciseEdit(data: .constant(WorkoutTemplate.sampleData[0].data), exercisesList: .constant([]), saveAction: {})
                .environment(\.colorScheme, .dark)
        }
    }
}
