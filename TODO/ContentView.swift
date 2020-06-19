//
//  ContentView.swift
//  TODO
//
//  Created by Safwan Saigh on 11/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = TaskStore()
    
    var body: some View {
        TabView {
            TodoList(store: self.store).tabItem {
                Image(systemName: "doc.plaintext")
                Text("TODO")
            }
            DoneTaskView(store: self.store).tabItem {
                Image(systemName: "checkmark.rectangle.fill")
                Text("Done TODOs")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
