//
//  TodoList.swift
//  TODO
//
//  Created by Safwan Saigh on 11/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI


struct TodoList: View {
    @ObservedObject var store = TaskStore()
    
    @State var selectedIds: Set<UUID> = []
    @State var title = ""
    @State var des = ""
    @State var period = ""
    
    var body: some View {
        
        NavigationView{
            List(selection: $selectedIds) {
                Section {
                    HStack {
                        VStack {
                            TextField("Title", text: self.$title)
                            TextField("Description", text: self.$des)
                            TextField("After", text: self.$period)

                        }
                        Button(action:  {
                            self.addTask()
                            self.title = ""
                            self.des = ""
                            self.period = ""
                        } ) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.green)
                                .imageScale(.large)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                
                Section(header: self.store.tasks.isEmpty ? Text("") : Text("Active Tasks")) {
                    ForEach(store.tasks) { task in
                        TaskView(task: task)
                    }
                    .onDelete { index in
                        self.store.tasks.remove(at: index.first!)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.editMode, .constant(EditMode.active))
            .navigationBarItems(trailing:
                Button(action: { self.store.tasks.removeAll { (task) -> Bool in
                    if self.selectedIds.contains(task.id){
                        self.store.doneTasks.append(task)
                        self.selectedIds.remove(task.id)
                        return true
                    }
                    return false
                    } }) {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.red)
                }
            )
            .navigationBarTitle(Text("TODO"))
        }
    }
    
    func addTask(){
        self.store.tasks.append(.init(period: Int(self.period)!, title: self.title, des: self.des))
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}

struct TaskView: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(self.task.title)
                    .font(.system(size: 20, weight: .medium))
                Text(self.task.des)
                    .font(.subheadline)
                    .lineLimit(2)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                calculateImportance(period: self.task.period)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(5)
            }
            .frame(width: 80, height: 70)
            
            
        }
        .padding()
    }
    
    
    func calculateImportance(period: Int) -> Text {
        if period <= 1{
            return Text("Urgent").foregroundColor(Color.red)
        }else if period < 4{
            return Text("Important").foregroundColor(Color.pink)
        }else if period < 6{
            return Text("Better to do").foregroundColor(Color.green)
        }else{
            return Text("Not Important").foregroundColor(Color.green)
        }
    }
}

struct Task: Identifiable {
    var id = UUID()
    var period: Int
    var title: String
    var des: String
}


var tasksData: [Task] = [
    .init(period: 2, title: "ICS 202", des: "Homework chapter 3"),
    .init(period: 3, title: "ICS 233", des: "Quiz section 5"),
    .init(period: 4, title: "ICS 254", des: "Report"),
]

