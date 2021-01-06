//
//  TabController.swift
//  DrinkOrder
//
//  Created by Tommy on 2021/1/5.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom tab bar
        self.tabBar.tintColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 76/255, blue: 97/255, alpha: 1))
        self.tabBar.unselectedItemTintColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 76/255, blue: 97/255, alpha: 0.6))
        self.tabBar.barTintColor = UIColor(cgColor: CGColor(srgbRed: 193/255, green: 162/255, blue: 113/255, alpha: 1))
        
        // Do any additional setup after loading the view.
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
