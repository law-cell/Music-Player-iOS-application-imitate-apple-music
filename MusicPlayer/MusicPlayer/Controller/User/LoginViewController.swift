//
//  LoginViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/3.
//

import UIKit
import LeanCloud


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    

    @IBAction func clickLoginButton(_ sender: Any) {
        if emailTextField != nil && passwordTextField != nil{
            _ = LCUser.logIn(email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result {
            case .success(object: let user):
                print(user)
                CurrentUser.userName = (user.username?.stringValue)!
                CurrentUser.userEmail = (user.email?.stringValue)!
                CurrentUser.userId = (user.objectId?.stringValue)!
                CurrentUser.islogin = true
                print(CurrentUser.userName)
                let alert = UIAlertController(title: "登录成功", message: nil, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:{ action in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }))

                self.present(alert, animated: true)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
//                self.navigationController?.popToRootViewController(animated: true)
            case .failure(error: let error):
                print(self.emailTextField.text!+self.passwordTextField.text!)
                print(error)
                let alert = UIAlertController(title: "账号或者密码错误", message: nil, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }
        }
        }else{
            print("邮箱或者密码不能为空")
        }
        
        
//        let query = LCQuery(className: "Music")
        
//        query.whereKey("musicName", .equalTo("myMusic"))
//        _ = query.find { result in
//            switch result {
//            case .success(objects: let musics):
//                let musicData = musics[0].get("musicData") as? LCObject
//                print((musicData?.url?.stringValue)!)
//                //print(file1?.stringValue)
//                // students 是包含满足条件的 Student 对象的数组
//                break
//            case .failure(error: let error):
//                print(error)
//            }
//        }
        //这样可以拿到File
        
        

    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
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
