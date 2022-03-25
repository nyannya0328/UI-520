//
//  Topping.swift
//  UI-520
//
//  Created by nyannyan0328 on 2022/03/25.
//

import SwiftUI

struct Topping: Identifiable {
    var id = UUID().uuidString
    var toppingName : String
    var isAdded : Bool = false
    var randomTopicPosticion : [CGSize] = []
}

