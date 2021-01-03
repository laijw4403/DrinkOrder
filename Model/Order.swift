//
//  Order.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/30.
//

import Foundation
struct DrinkOrder: Codable {
    var fields: OrderData
}
struct OrderData: Codable {
    var ordererName: String
    var drinkName: String
    var temp: String
    var sugar: String
    var size: String
    var feed: String
    var price: Int
    var quantity: Int
}
