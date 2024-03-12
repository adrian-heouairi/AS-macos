//
//  DataRow.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import SwiftUI

struct DataRowView : View {
    var item : DataItem
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            if item.isTagged {
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    DataRowView(item: DataItem(id: 3, name: "Toto", isTagged: true))
}
