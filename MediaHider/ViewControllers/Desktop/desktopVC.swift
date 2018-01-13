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

class desktopVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickCamera(_ sender: Any) {
        // show camera
        let ac = UIAlertController.init()
        let ac1 = UIAlertAction.init(title: "Take Picture", style: .default) { (action) in
            takePhoto(sender: nil)
        }
        let ac2 = UIAlertAction.init(title: "Take Video", style: .default) { (action) in
            takeVideo(sender: nil)
        }
        ac.addAction(ac1)
        ac.addAction(ac2)
        
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
            //pickerController.mediaTypes = [kUTTypeMovie as! String]
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
                        
                    }
                }else if stringType == kUTTypeImage as String {
                    // CheckInAttrViewController
                    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                        // image process
                        
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
