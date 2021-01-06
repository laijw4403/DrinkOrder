//
//  MenuViewController.swift
//  DrinkOrder
//
//  Created by Tommy on 2020/12/27.
//

import UIKit
private let reuseIdentifier = "MenuCollectionViewCell"
public let apiKey = "keyIbYMGvbvLMiZal"
class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var menuCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    var menuData: Array<Record> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCell()
        fetchData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
        cell.drinkNameLabel.text = menuData[indexPath.item].fields.drinkName
        cell.drinkImageView.image = nil
        if let imageUrl = URL(string: menuData[indexPath.item].fields.drinkImage[0].url) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.drinkImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell
    }
    
    
    func setCell() {
        menuCollectionViewFlowLayout.itemSize = CGSize(width: 182, height: 182)
        menuCollectionViewFlowLayout.estimatedItemSize = .zero
        menuCollectionViewFlowLayout.minimumInteritemSpacing = 10
        menuCollectionViewFlowLayout.minimumLineSpacing = 10
    }
    
    func fetchData() {
        print("fetch data...")
        
        let urlStr = "https://api.airtable.com/v0/appObOrAHeovNgbQb/Menu?sort[][field]=sort"
        let url = URL(string: urlStr)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "Get"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let result = try decoder.decode(ResponseData.self, from: data)
                    print("decode success")
                    self.menuData = result.records
                    DispatchQueue.main.async {
                        self.menuCollectionView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? DrinkOrderViewController
        if let item = menuCollectionView.indexPathsForSelectedItems?.first?.item {
            //print(menuData)
            controller?.drinkName = menuData[item].fields.drinkName
            controller?.drinkDescribe = menuData[item].fields.describe
            controller?.mediumPrice = menuData[item].fields.mediumPrice
            controller?.largePrice = menuData[item].fields.largePrice
            controller?.drinkImageURL = menuData[item].fields.drinkImage[0].url
        }
    }
    

}
