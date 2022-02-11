//
//  List.swift
//  shopping_list
//
//  Created by Jonmichael Cheung on 2/10/22.
//

import UIKit

class ListItems: Codable {
    var item: String
    var isComplete: Bool
    
    init(item: String, isComplete: Bool = false){
        self.item = item
        self.isComplete = isComplete
        
    }
}

extension ListItems: Equatable {
    static func == (lhs: ListItems, rhs: ListItems) -> Bool {
        return lhs.item == rhs.item
    }
}
