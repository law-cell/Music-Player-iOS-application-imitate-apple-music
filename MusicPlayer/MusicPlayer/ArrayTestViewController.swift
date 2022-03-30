//
//  ArrayTestViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/4.
//

import UIKit
import LeanCloud

class ArrayTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func arrayTest(_ sender: Any) {
        
        do {
            let userTom = LCObject(className: "_User", objectId: "luoyidan11@126.com")


            let music = LCObject(className: "Music", objectId: "60797885eeda6f6e7cc4861b")
            

            let userMusicMap = LCObject(className: "UserMusicMap")

            try userMusicMap.set("user", value: userTom)
            try userMusicMap.set("music", value: music)


            _ = userMusicMap.save { result in
                switch result {
                    case .success:
                        break
                    case .failure(error: let error):
                        print(error)
                }
            }
        } catch {
            print(error)
        }

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
