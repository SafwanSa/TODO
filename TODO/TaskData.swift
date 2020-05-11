//
//  TaskData.swift
//  TODO
//
//  Created by Safwan Saigh on 11/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI
import Combine

class TaskStore: ObservableObject{
    @Published var tasks: [Task] = tasksData
    @Published var doneTasks: [Task] = [
        .init(period: 5, title: "ICS 202", des: "Major II")
    ]
}
