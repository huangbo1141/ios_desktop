import UIKit


class login: baseVc {
    
    //*********************************************
    // MARK: Variables
    //*********************************************
    
    // UI Related
    
    let passwordContainerView = PasswordContainerView.create(withDigit: 6)
    
    // Others
    
    //*********************************************
    // MARK: Outlets
    //*********************************************
    
    //*********************************************
    // MARK: Defaults
    //*********************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupPasswordContainerView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//*********************************************
// MARK: Actions
//*********************************************

extension login
{
    /**
     #selectors
     */
    
    
    /**
     @IBActions
     */
}


//*********************************************
// MARK: Custom Methods
//*********************************************

extension login
{
    /**
     Decorate UI
     */
    
    fileprivate func setupPasswordContainerView() {
        passwordContainerView.tintColor = G_colorBlueLight
        passwordContainerView.highlightedColor = G_colorBlueLight
        passwordContainerView.delegate = self
        
        self.view.addSubview(passwordContainerView)
        
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([NSLayoutConstraint.init(item: passwordContainerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
                                  NSLayoutConstraint.init(item: passwordContainerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0),
                                  NSLayoutConstraint.init(item: passwordContainerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.7, constant: 0),
                                  NSLayoutConstraint.init(item: passwordContainerView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.65, constant: 0)])
    }
}



extension login : PasswordInputCompleteProtocol {
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        
        if success
        {
            if let vc = G_getVc(ofType: TabBaseViewController(), FromStoryBoard: storyBoards.main , withIdentifier: vcIdentifiers.TabBaseVc)
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        
        if PasswordManager.verifyIsValidPassword(enteredPassword: input)
        {
            // when login success
            if let vc = G_getVc(ofType: desktopVC(), FromStoryBoard: storyBoards.main , withIdentifier: vcIdentifiers.desktopVC)
            {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        {
            Banner.customBannerShow(title: "Error", subtitle: "Please enter a valid password", colorCase: .error)
            passwordContainerView.wrongPassword()
        }
    }
}
