//
//  TodoList.swift
//  TODO
//
//  Created by Safwan Saigh on 11/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI
import Combine

struct TodoList: View {
    @ObservedObject var store = TaskStore()

    
    var body: some View {
        
        
        
        NavigationView{
            List {
                ForEach(store.tasks) { task in
                    TaskView(task: task)
                }
                .onDelete { index in
                    self.store.tasks.remove(at: index.first!)
                }
            }
                
            .navigationBarItems(leading:
                Button(action: addTask ) {
                Text("Add Task")
                }
                ,trailing: EditButton())
            .navigationBarTitle(Text("TODO"))
        }
        
        
        
        
        
    }
    
    func addTask(){
        store.tasks.append(.init(period: 2, category: "ICS 233", title: "Any thing", des: "hoho"))
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
        .padding(.vertical, 20)
    }
    func calculateImportance(period: Int) -> Text {
        if period < 1{
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
    var category: String
    var title: String
    var des: String
}


var tasksData: [Task] = [
    .init(period: 2, category: "ICS 202", title: "Homework", des: "chapter 3"),
    .init(period: 3, category: "ICS 233", title: "Homework", des: "chapter 5"),
    .init(period: 4, category: "ICS 254", title: "Homework", des: "section 3"),
    .init(period: 5, category: "ICS 202", title: "Quiz", des: "chapter 3")
]

class TaskStore: ObservableObject{
    @Published var tasks: [Task] = [
        .init(period: 2, category: "ICS 202", title: "Homework", des: "chapter 3"),
        .init(period: 3, category: "ICS 233", title: "Homework", des: "chapter 5"),
        .init(period: 4, category: "ICS 254", title: "Homework", des: "section 3"),
        .init(period: 5, category: "ICS 202", title: "Quiz", des: "chapter 3")
    ]
}
