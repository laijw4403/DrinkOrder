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
    static func saveToFile(records: [Record]) {
        print("save Drink Data")
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(records) {
            // 產生一個UserDefaults物件
            let userDefault = UserDefaults.standard
            userDefault.set(data, forKey: "records")
        }
    }

    static func readDrinkDataFromFile() -> [Record]? {
        print("read Drink Data")
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let data = userDefaults.data(forKey: "records"),
           let records = try? decoder.decode([Record].self, from: data) {
            return records
        } else {
            return nil
        }
    }
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



/*
enum DrinkDescribe: String, CaseIterable {
    case 熟成紅茶 = "解炸物/燒烤肉類油膩\n茶味濃郁帶果香"
    case 麗春紅茶 = "去除海鮮羶腥\n茶味較淡帶花香"
    case 太妃紅茶 = "咖啡與茶的神祕搭配"
    case 胭脂紅茶 = "蜜桃般的紅茶"
    case 雪藏紅茶 = "紅茶遇上冰淇淋"
    case 熟成冷露 = "手工冬瓜與茶\n更神秘比例搭配"
    case 雪花冷露 = "手工冬瓜獨奏"
    case 春芽冷露 = "手工冬瓜綠茶"
    case 春芽綠茶 = "綠茶，糸糸中帶點彔彔"
    case 春梅冰茶 = "春梅與冬瓜相遇"
    case 冷露歐蕾 = "手工冬瓜與鮮奶"
    case 熟成歐蕾 = "熟成鮮奶茶"
    case 白玉歐蕾 = "珍奶不解釋"
    case 熟成檸果 = "每日限量的鮮檸紅茶，\n整顆檸檬搭配7分糖最佳"
    case 胭脂多多 = "紅茶尬多多蹦出新滋味"
    case 雪藏末茶 = "抹茶遇上冰淇淋"
    case 黃玉歐蕾 = "布丁鮮奶茶"
    case 磨玉歐特 = "燕麥與咖啡凍在紅茶中相遇"
}


// cast String as Enum
extension CaseIterable {
    static func from(string: String) -> Self? {
        return Self.allCases.first { string == "\($0)" }
    }
    func toString() -> String { "\(self)" }
}
*/
