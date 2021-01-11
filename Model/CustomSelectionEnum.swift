//
//  CustomSelectionEnum.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/28.
//

import Foundation

enum OrderInfo: CaseIterable {
    case orderer
    case size
    case sugar
    case temp
    case feed
}
enum Size: String, CaseIterable {
    case medium = "中杯"
    case large = "大杯"
}
enum Sugar: String, CaseIterable {
    case normal = "正常糖"
    case less = "少糖"
    case half = "半糖"
    case few = "微糖"
    case two_cent = "二分糖"
    case cent = "一分糖"
    case none = "無糖"
}

enum Temp: String, CaseIterable {
    case normalIce = "正常冰"
    case less = "少冰"
    case few = "微冰"
    case none = "去冰"
    case totalNone = "完全去冰"
    case normal = "常溫"
    case warm = "溫"
    case hot = "熱"
}

enum Feed: String, CaseIterable {
    case white = "白玉"
    case black = "墨玉"
}

enum FeedPrice: Int, CaseIterable {
    case white = 10
    case black = 15
}

// cast String as Enum
extension CaseIterable {
    static func from(string: String) -> Self? {
        return Self.allCases.first { string == "\($0)" }
    }
    func toString() -> String { "\(self)" }
}
