//
//  desktopVC.swift
//  MediaHider
//
//  Created by q on 1/13/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos

class desktopVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
   
    
    @IBAction func clickCamera(_ sender: UIView) {
        // show camera
        let ac = UIAlertController.init()
        let ac1 = UIAlertAction.init(title: "Take Picture", style: .default) { (action) in
            //hgc
            let globalswift = GlobalSwift.sharedManager
            GlobalSwift.checkAVCapturePermission(completion: { (ret) in
                if ret {
                    self.takePhoto(sender: nil)
                }
            })
            
            
        }
        let ac2 = UIAlertAction.init(title: "Take Video", style: .default) { (action) in
            let globalswift = GlobalSwift.sharedManager
            GlobalSwift.checkAVCapturePermission(completion: { (ret) in
                if ret {
                    self.takeVideo(sender: nil)
                }
            })
        }
        ac.addAction(ac1)
        ac.addAction(ac2)
        
        ac.popoverPresentationController?.sourceView = sender
        self.present(ac, animated: true) {
            //
            debugPrint("action")
        }
    }
    var pickerController = UIImagePickerController()
    
    func takePhoto(sender: AnyObject?) {
        let vc = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController = UIImagePickerController();
            pickerController.allowsEditing = false;
            pickerController.delegate = self
            pickerController.sourceType = .camera
            pickerController.cameraCaptureMode = .photo
            
            vc.present(pickerController, animated: true, completion: nil)
        }else{
            debugPrint("Camera is not available")
        }
    }
    func takeVideo(sender: AnyObject?) {
        // 1 Check if project runs on a device with camera available
        let vc = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 2 Present UIImagePickerController to take video
            pickerController = UIImagePickerController()
            pickerController.sourceType = .camera
            pickerController.mediaTypes = [kUTTypeMovie as! String]
            pickerController.delegate = self
            pickerController.videoMaximumDuration = 10.0
            pickerController.cameraCaptureMode = .video
            
            vc.present(pickerController, animated: true, completion: nil)
        }
        else {
            
            debugPrint("Camera is not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
        
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL
                    if let url = urlOfVideo {
                        do {
                            let videoData = try Data.init(contentsOf: url)
                            let videoName = url.lastPathComponent
                            
                            photosManager.enumSourceType = .videos
                            
                            if let itemName = photosManager.writeItem(fromData: videoData, withName: videoName)
                            {
                                if let itemNameData: Data = itemName.data(using: .utf8)
                                {
                                    G_loaderShow()
                                    DispatchQueue.main.async {
                                        
                                        let pass = "Video\(arc4random_uniform(999999999))"
                                        
                                        let data = RNCryptor.encrypt(data: itemNameData, withPassword: pass)
                                        
                                        let obj = ModelMedia()
                                        
                                        obj.encryptedNameOfItem = data
                                        obj.password = pass
                                        obj.isVideo = true
                                        
                                        PR_RealmManager.Add(objectToRealm: obj, update: false, errorMessage: "Inn")
                                        G_loaderHide()
                                        
                                    }
                                }
                            }
                        }catch{
                            
                        }
                        
                    }
                }else if stringType == kUTTypeImage as String {
                    // CheckInAttrViewController
                    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                        // image process
                        debugPrint("xxxx")
                        if let data =  UIImageJPEGRepresentation(image, 0.25)
                        {
                            var imgName = "myphoto"
                            
                            photosManager.enumSourceType = .photos
                            
                            if let itemName = photosManager.writeItem(fromData: data, withName: imgName)
                            {
                                if let itemNameData: Data = itemName.data(using: .utf8)
                                {
                                    G_loaderShow()
                                    DispatchQueue.main.async {
                                        
                                        let pass = "\(arc4random_uniform(999999999))"
                                        
                                        let data = RNCryptor.encrypt(data: itemNameData, withPassword: pass)
                                        
                                        let obj = ModelMedia()
                                        
                                        obj.encryptedNameOfItem = data
                                        obj.password = pass
                                        
                                        PR_RealmManager.Add(objectToRealm: obj, update: false, errorMessage: "Inn")
                                        G_loaderHide()
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
        
        // 3
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func clickPhotos(_ sender: Any) {
        
        if let vc = G_getVc(ofType: TabBaseViewController(), FromStoryBoard: storyBoards.main , withIdentifier: vcIdentifiers.TabBaseVc)
        {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func clickNotes(_ sender: Any) {
    }
    @IBAction func clickMessages(_ sender: Any) {
    }
    
    @IBAction func clickPhone(_ sender: Any) {
    }
    @IBAction func clickContacts(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
