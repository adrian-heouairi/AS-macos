//
//  DataDetail.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import SwiftUI

struct DataDetailView : View {
    var item : DataItem
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                content:  {
            Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                Divider()
                GridRow {
                    Text("Name:").gridColumnAlignment(.trailing)
                        .bold()
                    Text(item.name)
                }
                Divider()
                GridRow {
                    Text("Id:").bold()
                    Text("\(item.id)")
                }
                Divider()
                GridRow {
                    Text("Tagged:").bold()
                    Text("\(String(item.isTagged))")
                }
                Divider()
            }.tabItem {
                Label("List", systemImage: "list.bullet")
            }.tag(1)
            
            
            
            
            
            VStack {
                Text(item.name)
                Spacer()
                Text("\(item.id)")
                Spacer()
                Text("\(String(item.isTagged))")
            }.tabItem {
                Label("", systemImage: "person")
            }.tag(2)
        })
    }
}

#Preview {
    DataDetailView(item: DataItem(id: 23, name: "Bidule", isTagged: false))
}
