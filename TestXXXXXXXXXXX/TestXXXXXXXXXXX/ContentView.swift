//
//  ContentView.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager : DataManager
    var body: some View {
        
            DataListView(manager: manager)
        
    }
}

#Preview {
    ContentView(manager: DataManager(false))
}
