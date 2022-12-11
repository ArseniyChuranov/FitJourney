//
//  EditExerciseCardView.swift
//  Fit Journey


//
//  Created by Arseniy Churanov on 12/3/22.
//

import SwiftUI

struct AddExerciseSetView: View {
    @Binding var exercise: WorkoutTemplate.ExerciseData
    
    @State private var reps = ""
    @State private var weight = ""
    
    @State private var isPresentingAddNewExerciseView = false
    
    @State private var exerciseNewSets = ExerciseSet.Sets()
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Text(exercise.workoutName)
                    .font(.title)
            }
            
            HStack {
                TextField("Reps", text: $reps)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
                TextField("Weight", text: $weight)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
            }
            HStack {
                Button(action: {
                    withAnimation {
                        let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                                 reps: Int(reps) ?? 1,
                                                 weight: Int(weight) ?? 1
                        )
                        
                        exercise.exerciseSets.append(newSet)
                        
                        reps = ""
                        weight = ""
                         
                        isPresentingAddNewExerciseView = false
                    }
                }) {
                    Text("Add New Set")
                        .font(.largeTitle)
                        .disabled(weight.isEmpty)
                }
            }
        }
    }
}

struct AddExerciseSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseSetView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
    }
}


//Text("Exercise name")
//    .font(.title)
//



// exerciseSets: WorkoutTemplate.sampleData[0].exercise[0].exerciseSets[0].setsData


/*
 
 HStack {
     Text(exercise.workoutName)
         .font(.title)
 }
 List {
     ForEach(exercise.exerciseSets) {individualSet in
         HStack {
             Text("Set:")
             Text(String("\(individualSet.sets)"))
             Spacer()
             Text("Reps:")
             Text(String(individualSet.reps))
             Spacer()
             Text("Weight:")
             Text(String(individualSet.weight))
         }
         //.frame(height: 15)
         
         
     }
     .onDelete(perform: {indices in exercise.exerciseSets.remove(atOffsets: indices)})
     
     HStack {
         Text("Add Set")
         TextField("Reps", text: $reps)
             .keyboardType(.numberPad)
         TextField("Weight", text: $weight)
             .keyboardType(.numberPad)
         Button (action: {
             
         
             
             // i would assume any changes in a view forces app to send back to a previous view.
             // im not sure i have a solution for this yet
             
             // look into dispatchQueue and firstResponder
             
             let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                      reps: Int(reps) ?? 1,
                                      weight: Int(weight) ?? 1
             )
             
             exercise.exerciseSets.append(newSet)
             
             reps = ""
             weight = ""
              
             // isPresentingAddNewExerciseView = false // is this a problem?? // yes
             
             // after submitting and updating current view it returns to original link
             
             
         }) {
             Image(systemName: "plus")
         }
         //.disabled(weight.isEmpty)
     }
     .padding()
     //.background(.white)
     .cornerRadius(15)
     // .backgroundStyle(.opacity(2.0)) // might be unnecessary
     
     
 }
}
 
 
 
 
HStack {
     Text("Add New Set")
         .font(.title)
 }
 HStack {
     Text("Add Set")
     TextField("Reps", text: $reps)
         .keyboardType(.numberPad)
     TextField("Weight", text: $weight)
         .keyboardType(.numberPad)
     Button (action: {
         let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                  reps: Int(reps) ?? 1,
                                  weight: Int(weight) ?? 1
         )
         
         exercise.exerciseSets.append(newSet)
         
         reps = ""
         weight = ""
          
         isPresentingAddNewExerciseView = false
         
         
     }) {
         Image(systemName: "plus")
     }
     .disabled(weight.isEmpty)
 }
 .padding()
 //.background(.white)
 .cornerRadius(15)
 // .backgroundStyle(.opacity(2.0)) // might be unnecessary
 
 
 */
