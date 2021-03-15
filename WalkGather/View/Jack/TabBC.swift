//
//  TabBC.swift
//  WalkGather
//
//  Created by JackYu on 2021/3/15.
//

import UIKit

class TabBC: UITabBarController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        // 點選元件之顏色
        self.tabBar.tintColor = UIColor.init(red: 153/255, green: 204/255, blue: 0, alpha: 1)
        
        // bar之背景顏色
        // self.tabBar.barTintColor = UIColor.red
        
        // 未選擇之元件顏色
        // self.tabBar.unselectedItemTintColor = UIColor.black
    }

}
