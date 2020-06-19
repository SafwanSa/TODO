//
//  SwiftUIView.swift
//  TODO
//
//  Created by Safwan Saigh on 12/05/2020.
//  Copyright © 2020 Safwan Saigh. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State var date = Date()
    
    var body: some View {
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
            Text("Select a date")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
