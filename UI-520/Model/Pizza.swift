//
//  Pizza.swift
//  UI-520
//
//  Created by nyannyan0328 on 2022/03/25.
//

import SwiftUI

struct Pizza: Identifiable {
    var id = UUID().uuidString
    var breadName : String
    var toppings : [Topping] = []
}

