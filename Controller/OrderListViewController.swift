//
//  OrderListViewController.swift
//  DrinkOrder
//
//  Created by Tommy on 2021/1/5.
//

import UIKit
private let reuseIdentifier = "OrderListTableViewCell"

class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var orderListTableView: UITableView!
    @IBOutlet weak var totalQuatityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let urlStr = "https://api.airtable.com/v0/appObOrAHeovNgbQb/OrderData"
    var orderDrinkData = [DrinkOrder]()
    var loadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingView()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderDrinkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderListTableViewCell
        let orderData = orderDrinkData[indexPath.row].fields
        cell.ordererNameLabel.text = orderData.ordererName
        cell.drinkNameLabel.text = orderData.drinkName
        cell.drinkSizeLabel.text = orderData.size
        cell.drinkSugarLabel.text = orderData.sugar
        cell.drinkTempLabel.text = orderData.temp
        cell.drinkAddFeedLabel.text = "加料：" + orderData.feed
        cell.drinkPriceLabel.text = orderData.price.description
        cell.drinkQuantityLabel.text = orderData.quantity.description
        if let imageUrl = URL(string: orderData.drinkImage) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.drinkImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell
    }
    
    // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let controller = UIAlertController(title: "確定要刪除嗎?", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default) { (_) in
                let dataID = self.orderDrinkData[indexPath.row].id
                self.deleteData(urlStr: self.urlStr, id: dataID)
                self.orderDrinkData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(okAction)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        }
    }
    func createLoadingView() {
        loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
        loadingActivityIndicator.center = view.center
        view.addSubview(loadingActivityIndicator)
    }
    
    func updateUI() {
        print("updateUI")
        fetchData(urlStr: urlStr) { (orderData) in
            print("fetch success")
            guard let orderData = orderData else { return }
            self.orderDrinkData = orderData
            DispatchQueue.main.async {
                print("enter main queue")
                self.loadingActivityIndicator.stopAnimating()
                self.initTotal()
                self.orderListTableView.reloadData()
            }
        }
    }
    
    func initTotal() {
        var totalQuantity = 0
        var totalPrice = 0
        orderDrinkData.forEach { (DrinkOrder) in
            totalQuantity += DrinkOrder.fields.quantity
            totalPrice += DrinkOrder.fields.price
        }
        self.totalQuatityLabel.text = totalQuantity.description
        self.totalPriceLabel.text = totalPrice.description
    }
    
    func fetchData(urlStr: String, completionHandler: @escaping ([DrinkOrder]?) -> Void) {
        print("fetch data...")
        if let url = URL(string: urlStr) {
            loadingActivityIndicator.startAnimating()
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "Get"
            urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let result = try decoder.decode(OrderRecords.self, from: data)
                        print("decode success")
                        completionHandler(result.records)
                    } catch {
                        completionHandler(nil)
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func deleteData(urlStr: String, id: String) {
        print("delete Data")
        let deleteUrlStr = urlStr + "/\(id)"
        if let url = URL(string: deleteUrlStr) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
                if let data = data,
                   let dic = try? JSONDecoder().decode([String:Bool].self, from: data),
                   dic["delete"] == true {
                    print("delete donw")
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                } else {
                    print("delete fail")
                }
            }.resume()
        }
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


