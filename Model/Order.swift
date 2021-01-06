//
//  Order.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/30.
//

import Foundation
struct OrderRecords: Codable {
    var records: [DrinkOrder]
}

struct DrinkOrder: Codable {
    var id: String
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
    var drinkImage: String
}

