//
//  DataList.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import SwiftUI

struct DataListView: View {
    @ObservedObject var manager: DataManager
    @State var taggedOnly = false
    var items : [DataItem] {
        manager.items.filter {
            l in (taggedOnly && l.isTagged) || (!taggedOnly)
        }
    }
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $taggedOnly, label: {
                    Text("Favorites only")
                })
                ForEach(items) {
                    
                    d in
                    NavigationLink {
                        DataDetailView(item: d)
                    } label: {
                        DataRowView(item: d)
                    }
                }
            }.refreshable {
                print("refresh")
                manager.load()
            }
        }
    }
    
}

#Preview {
    DataListView(manager: DataManager(false))
}
