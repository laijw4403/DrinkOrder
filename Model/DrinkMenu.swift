//
//  DrinkMenu.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/27.
//

import Foundation

// 讓 enum conform CaseIterable 這個 protocol 之後，就可以使用 enum.allCases 取得包含所有 case 的 array

struct ResponseData: Codable {
    let records: [Record]
}

struct Record: Codable {
    let id: String
    let fields: Field
}

struct Field: Codable {
    let mediumPrice: Int
    let drinkName: String
    let largePrice: Int?
    let drinkImage: [DrinkImage]
    let describe: String?
    struct DrinkImage: Codable {
        let url: String
    }
}
