//
//  DoneTaskView.swift
//  TODO
//
//  Created by Safwan Saigh on 11/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI

struct DoneTaskView: View {
    @ObservedObject var store = TaskStore()
    var body: some View {
        NavigationView {
            List {
                Section {
                      ForEach(store.doneTasks) { task in
                     TaskView(task: task)
                     }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("Done TODOs"))
        }
    }
}

struct DoneTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DoneTaskView()
    }
}
