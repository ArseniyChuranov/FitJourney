//
//  DetailView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct DetailView: View {
    // @Binding var workout: WorkoutTemplate // could that be a problem? // see if i can avoid binding altogether
    var workout: WorkoutTemplate // could that be a problem? // see if i can avoid binding altogether
    // var exercise: WorkoutTemplate.ExerciseData
    
    @EnvironmentObject var workoutStore: WorkoutStore
    
    
    var workoutIndex: Int {
        workoutStore.workouts.firstIndex(where: {$0.id == workout.id})!
    }
    
    var exerciseIndex: Int {
        workoutStore.workouts[workoutIndex].exercise.firstIndex(where: {$0.id == workout.exercise[workoutIndex].id})!
    }
   
    @State private var data = WorkoutTemplate.Data()

    
    @State private var isPresentingEditingView = false
    
    
    var body: some View {
        
        List {
            ForEach(workoutStore.workouts[workoutIndex].exercise) {exercise in
                NavigationLink(destination: ExerciseCardView(exercise: exercise, wholeExercise: workoutStore.workouts[workoutIndex])) {
                    // not the best idea.
                    ListExerciseCardView(exercise: exercise)
                }
                .isDetailLink(false)
                .listRowBackground(workoutStore.workouts[workoutIndex].theme.mainColor)
            }
            .onDelete {indices in
                workoutStore.workouts[workoutIndex].exercise.remove(atOffsets: indices)
            }
        }
        
        
        
        
        
        
        /*
         
         .navigationTitle(workout.title)
         .toolbar {
             Button("Edit") // maybe change it to a "+" with a feature of adding a new exercise
             {
                 isPresentingEditingView = true
                 // looks like its a case when it creates a new instance and depending on changes eigher opdates ot or discards. i need same structure with editing my views.
                 // however if im making any changes, would it make sense to keep them?
                 data = workout.data // signs data to a new value // may be useful
             }
         
         */
            
            /*
            .sheet(isPresented: $isPresentingEditingView) {
                // examine this, this section suppose to update information passed from one view to another.
                NavigationView {
                    DetailEditView(data: $data) // change to edit later // it takes data.
                        .navigationTitle(workout.title)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditingView = false
                                    
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditingView = false
                                    workoutStore.workouts[workoutIndex].update(from: data) // simply wrong // but might be necessary
                                }
                            }
                        }
                }
            }
            
            */
     //   }
    
    }
}

struct DetailView_Previews: PreviewProvider {
    static var workoutStore = WorkoutStore()
    
    static var previews: some View {
        Group {
            NavigationView {
                DetailView(workout: WorkoutTemplate.sampleData[0])
            }
            
            NavigationView {
                DetailView(workout: WorkoutTemplate.sampleData[0])
            }
            .environment(\.colorScheme, .dark)
        }
        .environmentObject(workoutStore)
    }
}




/*
 onDisappear {
     
     // add some functionality here maybe to allow it update info?
     // read about dispatchQueue
     
     // workout.update(from: data) // Im not sure itd what i need....  // lmao no
     /*
     setsData.sets = workout.setsData.sets // ???
     data = workout.data
     workout.update(from: data) // ?????????????
      */
     
     // not even sure i need that code above, looks like correct binding worked
     
     
     // it just works.............
     // print("After leaving workout.exercise looks like this")
     // print(workout.exercise)
 }
 
 */
