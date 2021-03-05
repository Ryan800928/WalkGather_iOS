//
//  MyGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/23.
//

import UIKit

class MyGroupViewController: UIViewController,UITableViewDataSource {
    
    
    
    
    

    @IBOutlet weak var myGroupTableView: UITableView!
    var myGroupImage = ["volcanic","xiangshan","yushan","xiangshan","xiangshan","xiangshan"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyGroupTableViewCell
        cell.myGroupImage.image = UIImage(named: myGroupImage[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myGroupTableView.dataSource = self

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
