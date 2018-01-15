//
//  CreatePassword.swift
//  MediaHider
//
//  Created by user on 24/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit

class createPassword  : baseVc {
    
    //*********************************************
    // MARK: Variables
    //*********************************************
    
    //*********************************************
    // MARK: Outlets
    //*********************************************
    
    @IBOutlet weak var txtFEnterPassword: UITextField!
    
    @IBOutlet weak var txtFConfirmPassword: UITextField!
    
    //*********************************************
    // MARK: Defaults
    //*********************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PasswordManager.isPasswordSetted
        {
            if let vc = G_getVc(ofType: login(), FromStoryBoard: storyBoards.main , withIdentifier: vcIdentifiers.Login)
            {
                self.navigationController?.pushViewController(vc, animated: false)
                
                return;
            }
        }
        
        self.txtFEnterPassword.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//*********************************************
// MARK: Actions
//*********************************************

extension createPassword
{
    /**
     #selectors
     */
    
    
    /**
     @IBActions
     */
    
    @IBAction func btnSubmit(_ sender : AnyObject)
    {
        if txtFConfirmPassword.text?.PR_isEmpty == true || txtFEnterPassword.text?.PR_isEmpty == true
        {
            Banner.customBannerShow(title: "Error", subtitle: "All Fields are mendatory.", colorCase: .error)
            return
        }
        
        if txtFConfirmPassword.text!.count != 6 || txtFEnterPassword.text!.count != 6
        {
            Banner.customBannerShow(title: "Error", subtitle: "Password length should be 6 characters", colorCase: .error)
            return
        }
        
        if txtFEnterPassword.text != txtFConfirmPassword.text
        {
            Banner.customBannerShow(title: "Error", subtitle: "Password and Confirm Password are not equal.", colorCase: .error)
            return;
        }
        
        if let vc = G_getVc(ofType: desktopVC(), FromStoryBoard: storyBoards.main , withIdentifier: vcIdentifiers.desktopVC)
        {
            /// Setting password to local.
            PasswordManager.set(PasswordOfUser: self.txtFConfirmPassword.text!)
            
            /// Sucess message
            Banner.customBannerShow(title: "Success", subtitle: "Password updated successfully", colorCase: .success)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}


//*********************************************
// MARK: Custom Methods
//*********************************************

extension createPassword
{
    
}


