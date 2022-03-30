//
//  SignUpViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/6.
//

import UIKit
import LeanCloud
class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailAgainTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    
    @IBAction func clickSignUpButton(_ sender: Any) {
        if (emailTextField.text != nil) && (emailAgainTextField.text != nil) && passwordTextField.text != nil && userNameTextField.text != nil && emailTextField.text == emailAgainTextField.text {
            do {
                // 创建实例
                let user = LCUser()

                // 等同于 user.set("username", value: "Tom")
                user.username = LCString(userNameTextField.text!)
                user.password = LCString(passwordTextField.text!)

                // 可选
                user.email = LCString(emailTextField.text!)
                

                // 设置其他属性的方法跟 LCObject 一样
                try user.set("gender", value: "secret")

                _ = user.signUp { (result) in
                    switch result {
                    case .success:
                        self.navigationController?.popToRootViewController(animated: true)
                        break
                    case .failure(error: let error):
                        print(error)
                        let alert = UIAlertController(title: "注册失败", message: nil, preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))

                        self.present(alert, animated: true)
                    }
                }
            } catch {
                print(error)
            }
            
        }else{
            let alert = UIAlertController(title: "注册失败", message: nil, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))

            self.present(alert, animated: true)
        }
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
