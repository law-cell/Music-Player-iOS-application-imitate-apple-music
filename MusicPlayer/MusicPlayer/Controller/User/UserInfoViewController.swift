//
//  UserInfoViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/4.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        userName.text = CurrentUser.userName
//        userEmail.text = CurrentUser.userEmail
//        // Do any additional setup after loading the view.
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if CurrentUser.islogin == true{
            
        userName.text = CurrentUser.userName
        userEmail.text = CurrentUser.userEmail
            loginButton.isHidden = true
            signInButton.isHidden = true
            logOutButton.isHidden = false
            }
        
        if CurrentUser.islogin == false{
            
            userName.text = CurrentUser.userName
            userEmail.text = CurrentUser.userEmail
            loginButton.isHidden = false
            signInButton.isHidden = false
            logOutButton.isHidden = true
        }
    }
    
    
    
    @IBAction func clickLogOutButton(_ sender: Any) {
        CurrentUser.removeAll()
        self.loadView()
        logOutButton.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
        
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
