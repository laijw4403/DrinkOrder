//
//  DrinkOrderViewController.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/28.
//

import UIKit
private let reuseIdentifier = "DrinkOrderTableViewCell"

class DrinkOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var customSelectionTableView: UITableView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDescribeLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var drinkQuantityLabel: UILabel!
    @IBOutlet weak var addToOrderListButton: UIButton!
    
    var ordererName: String!
    var drinkName: String!
    var drinkDescribe: String?
    var sugar: String!
    var temp: String!
    var feed = ["",""]
    var size: String!
    var drinkPrice: Int!
    var mediumPrice: Int!
    var largePrice: Int?
    var drinkQuantity = 1
    
    var orderPrice: Int?
    var feedPrice = 0
    
    var sizeChecked = [Bool]()
    var tempChecked = [Bool]()
    var sugarChecked = [Bool]()
    var feedChecked = [Bool]()
    
    let apiKey = "keyIbYMGvbvLMiZal"
    let urlStr = "https://api.airtable.com/v0/appObOrAHeovNgbQb/OrdererData"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        initCheck()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        OrderInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let orderInfoType = OrderInfo.allCases[section]
        switch orderInfoType {
        case .size:
            return "容量"
        case .sugar :
            return "甜度"
        case .temp :
            return "溫度"
        case .feed :
            return "加料"
        case .orderer:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let orderInfoType = OrderInfo.allCases[section]
        switch orderInfoType {
        case .orderer:
            return 1
        case .size :
            guard let _ = largePrice else { return 1 }
            return Size.allCases.count
        case .sugar :
            return Sugar.allCases.count
        case .temp :
            return Temp.allCases.count
        case .feed :
            return Feed.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderInfoType = OrderInfo.allCases[indexPath.section]
        
        switch orderInfoType {
        case .orderer :
            let cell = customSelectionTableView.dequeueReusableCell(withIdentifier: "OrdererTableViewCell") as! OrdererTableViewCell
            cell.ordererLabel.text = "訂購人"
            cell.ordererNameTextField.placeholder = "請輸入名字"
            cell.ordererNameTextField.delegate = self
            return cell
        case .size :
            let cell = customSelectionTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DrinkOrderTableViewCell
            cell.addPriceLabel.isHidden = true
            cell.addFeedPriceLabel.isHidden = true
            cell.selectionLabel.text = Size.allCases[indexPath.row].rawValue
            if sizeChecked[indexPath.row] {
                cell.radioButtonImage.image = UIImage(named: "radio_on")
            } else {
                cell.radioButtonImage.image = UIImage(named: "radio_off")
            }
            return cell
        case .sugar :
            let cell = customSelectionTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DrinkOrderTableViewCell
            cell.addPriceLabel.isHidden = true
            cell.addFeedPriceLabel.isHidden = true
            cell.selectionLabel.text = Sugar.allCases[indexPath.row].rawValue
            if sugarChecked[indexPath.row] {
                cell.radioButtonImage.image = UIImage(named: "radio_on")
            } else {
                cell.radioButtonImage.image = UIImage(named: "radio_off")
            }
            return cell
        case .temp :
            let cell = customSelectionTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DrinkOrderTableViewCell
            cell.addPriceLabel.isHidden = true
            cell.addFeedPriceLabel.isHidden = true
            cell.selectionLabel.text = Temp.allCases[indexPath.row].rawValue
            if tempChecked[indexPath.row] {
                cell.radioButtonImage.image = UIImage(named: "radio_on")
            } else {
                cell.radioButtonImage.image = UIImage(named: "radio_off")
            }
            return cell
        case .feed :
            let cell = customSelectionTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DrinkOrderTableViewCell
            cell.selectionLabel.text = Feed.allCases[indexPath.row].rawValue
            if feedChecked[indexPath.row] {
                cell.radioButtonImage.image = UIImage(named: "radio_on")
            } else {
                cell.radioButtonImage.image = UIImage(named: "radio_off")
            }
            
            cell.addPriceLabel.isHidden = false
            cell.addFeedPriceLabel.isHidden = false
            if cell.selectionLabel.text == Feed.white.rawValue {
                cell.addFeedPriceLabel.text = String(FeedPrice.white.rawValue)
            } else {
                cell.addFeedPriceLabel.text = String(FeedPrice.black.rawValue)
            }
            return cell
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderInfoType = OrderInfo.allCases[indexPath.section]
        switch orderInfoType {
        case .orderer :
            return
        case .size:
            sizeChecked = Array(repeating: false, count: Size.allCases.count)
            sizeChecked[indexPath.row] = !sizeChecked[indexPath.row]
            size = Size.allCases[indexPath.row].rawValue
            if sizeChecked[indexPath.row] {
                if indexPath.row == 0 {
                    drinkPrice = mediumPrice
                } else {
                    guard let largePrice = largePrice else { return drinkPrice = mediumPrice }
                    drinkPrice = largePrice
                }
            }
            showOrderPrice()
        case .sugar:
            sugarChecked = Array(repeating: false, count: Sugar.allCases.count)
            sugarChecked[indexPath.row] = !sugarChecked[indexPath.row]
            sugar = Sugar.allCases[indexPath.row].rawValue
        case .temp:
            tempChecked = Array(repeating: false, count: Temp.allCases.count)
            tempChecked[indexPath.row] = !tempChecked[indexPath.row]
            temp = Temp.allCases[indexPath.row].rawValue
        case .feed:
            feedChecked[indexPath.row] = !feedChecked[indexPath.row]
            print(feedChecked[indexPath.row])
            if feedChecked[indexPath.row] {
                feedPrice += FeedPrice.allCases[indexPath.row].rawValue
                feed[indexPath.row] = Feed.allCases[indexPath.row].rawValue
            } else {
                feedPrice -= FeedPrice.allCases[indexPath.row].rawValue
                feed[indexPath.row] = ""
            }
            showOrderPrice()
        }
        tableView.reloadData()
    }
    
    func initCheck() {
        sizeChecked = Array(repeating: false, count: Size.allCases.count)
        tempChecked = Array(repeating: false, count: Temp.allCases.count)
        sugarChecked = Array(repeating: false, count: Sugar.allCases.count)
        feedChecked = Array(repeating: false, count: Feed.allCases.count)
    }
    
    func display() {
        if let drinkName = drinkName,
           let drinkDescribe = drinkDescribe {
            drinkNameLabel.text = drinkName
            drinkDescribeLabel.text = drinkDescribe
        } else {
            drinkNameLabel.text = drinkName
            drinkDescribeLabel.text = ""
        }
        drinkPrice = mediumPrice
        showOrderPrice()
    }
    
    func showOrderPrice() {
        orderPrice = (drinkPrice + feedPrice) * drinkQuantity
        orderPriceLabel.text = orderPrice?.description
    }
    
    @IBAction func addDrinkNumber(_ sender: Any) {
        drinkQuantity += 1
        drinkQuantityLabel.text = drinkQuantity.description
        showOrderPrice()
    }
    
    @IBAction func reduceDrinkNumber(_ sender: Any) {
        if drinkQuantity > 1 {
            drinkQuantity -= 1
        } else {
            drinkQuantity = 1
        }
        drinkQuantityLabel.text = drinkQuantity.description
        showOrderPrice()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ordererName = textField.text
        print(ordererName)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
       return true
    }
    
    func postOrder() {
        print(ordererName,
              drinkName,
              temp,
              sugar,
              size,
              feed,
              orderPrice,
              drinkQuantity)
        
        let orderData = OrderData(ordererName: ordererName, drinkName: drinkName, temp: temp, sugar: sugar, size: size, feed: feedToString(), price: orderPrice!, quantity: drinkQuantity)
        let drinkOrder = DrinkOrder(fields: orderData)
        

        let url = URL(string: urlStr)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        print("bulid jsonEncoder")
        if let data = try? jsonEncoder.encode(drinkOrder) {
            print("try json encoder")
            URLSession.shared.uploadTask(with: urlRequest, from: data) { (retData, res, err) in
                if let response = res as? HTTPURLResponse,
                   response.statusCode == 200,
                   err == nil{
                    print("success")
                } else {
                    print(err)
                    print("error")
                }
            }.resume()
        }
    }
    
    func feedToString() -> String {
        var feedStr = ""
        for feed in feed {
            feedStr += feed+" "
        }
        return feedStr
    }
    
    @IBAction func addToOrderList(_ sender: Any) {
        let controller = UIAlertController(title: "加入訂單", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "確定", style: .default) { (_) in
            self.postOrder()
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(confirmAction)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
