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
    @State var date = Date()
    
    private var showAdd: Bool {
        !title.isEmpty && !des.isEmpty && !period.isEmpty
    }
    
    var body: some View {
        NavigationView{
            List(selection: $selectedIds) {
                
                Section(header:
                    Group{
                        if self.showAdd {
                            Button(action:  {
                                self.addTask()
                                self.title = ""
                                self.des = ""
                                self.period = ""
                            } ) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.green)
                                        .imageScale(.large)
                                    Text("ADD")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                ) {
                    HStack {
                        VStack(spacing: 20) {
                            TextField("Title", text: self.$title)
                            TextField("Description", text: self.$des)
//                            TextField("After", text: self.$period)
                        }
                    }
                    .animation(.spring())
                }
                
                Section(header: Text(self.store.tasks.isEmpty ? "You Don't have any tasks" : "Active Tasks")) {
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
        }
        .padding(.vertical, 16)
        .overlay(
            HStack {
                Spacer()
                VStack {
                    calculateImportance(period: self.task.period)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                }
                .frame(width: 10)
                .frame(maxHeight: .infinity)
            }
        )
    }
    
    
    func calculateImportance(period: Int) -> Color {
        if period <= 1{
            return (Color.red)
        }else if period < 3{
            return (Color.red.opacity(0.5))
        }else if period < 6{
            return (Color.green)
        }else{
            return (Color.green)
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

