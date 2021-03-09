//
//  NewAddGroupViewController.swift
//  WalkGather
//
//  Created by Ryan on 2021/2/4.
//

import UIKit

class NewAddGroupViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var walkCoverImage: UIImageView!
    
    @IBOutlet weak var normalSwitch: UISwitch!
    @IBOutlet weak var mediumSwitch: UISwitch!
    @IBOutlet weak var hellSwitch: UISwitch!
    
    @IBOutlet weak var naturalSwitch: UISwitch!
    @IBOutlet weak var artificialSwitch: UISwitch!
    @IBOutlet weak var mixSwitch: UISwitch!
    
    @IBOutlet weak var walkingStickSwitch: UISwitch!
    @IBOutlet weak var hikingShoesSwitch: UISwitch!
    @IBOutlet weak var waterproofBagSwitch: UISwitch!
    
    @IBOutlet weak var newAddFinishButton: UIButton!
    
    
    //宣告照片選擇控制
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        walkCoverImage.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    //地形難易按鈕功能
    @IBAction func difficultySwitch(_ sender: UISwitch) {
//一樣功能寫法
//        if sender.tag == normalSwitch.tag{
//
//        }
        if sender.tag == 1{
            mediumSwitch.isOn = false
            hellSwitch.isOn = false
        }else if sender.tag == 2{
            normalSwitch.isOn = false
            hellSwitch.isOn = false
        }else if sender.tag == 3{
            normalSwitch.isOn = false
            mediumSwitch.isOn = false
        }
    }
    //登山路型分類按鈕功能
    @IBAction func roadType(_ sender: UISwitch) {
        if sender.tag == 1{
            artificialSwitch.isOn = false
            mixSwitch.isOn = false
        }else if sender.tag == 2{
            naturalSwitch.isOn = false
            mixSwitch.isOn = false
        }else if sender.tag == 3{
            normalSwitch.isOn = false
            artificialSwitch.isOn = false
        }
    }
    //登山裝備按鈕功能
    @IBAction func walkEquipment(_ sender: UISwitch) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        normalSwitch.tag = 1
        mediumSwitch.tag = 2
        hellSwitch.tag = 3
        
        naturalSwitch.tag = 1
        artificialSwitch.tag = 2
        mixSwitch.tag = 3
        
//        walkingStickSwitch.tag = 1
//        hikingShoesSwitch.tag = 2
//        waterproofBagSwitch.tag = 3
        
        // Do any additional setup after loading the view.
    }
    //選擇按鈕
    func takeSelectAlbumPhoto (type:UIImagePickerController.SourceType
    ){
        let controller = UIImagePickerController()
        controller.sourceType = type
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    //選擇照片按鈕
    @IBAction func uploadPhotos(_ sender: UIButton) {
        let controller = UIAlertController(title: "選擇照片", message: nil, preferredStyle: .actionSheet)
        let albumAction = UIAlertAction(title: "相簿", style: .default) { _ in
            self.takeSelectAlbumPhoto(type: .photoLibrary)
        }
        controller.addAction(albumAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
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
