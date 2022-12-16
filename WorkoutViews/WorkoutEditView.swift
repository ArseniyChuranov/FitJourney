//
//  WorkoutEditView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/15/22.
//

import SwiftUI

struct WorkoutEditView: View {
    
    @Binding var workout: WorkoutTemplate.Data
    
    var body: some View {
        Text(workout.title)
    }
}

struct WorkoutEditView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEditView(workout: .constant(WorkoutTemplate.sampleData[0].data))
    }
}
