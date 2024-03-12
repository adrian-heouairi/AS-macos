//
//  DataItem.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import Foundation

struct DataItem : Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var isTagged: Bool
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case isTagged = "tag"
        }
}
