//
//  MainTabBarViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/4/13.
//

import UIKit
import LNPopupController
import LeanCloud
class MainTabBarViewController: UITabBarController {
    var popupNextButtonItem: UIBarButtonItem?
    var popupPlayButtonItem: UIBarButtonItem?
    var musicImage: UIImage?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        self.popupNextButtonItem = UIBarButtonItem(image: UIImage(systemName: "forward.fill"), style: .plain, target: nil, action: nil)
        self.popupPlayButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: nil, action: nil)
        
        self.popupItem.trailingBarButtonItems = [self.popupNextButtonItem!]
        self.popupItem.leadingBarButtonItems = [self.popupPlayButtonItem!]
        
    }
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        print("执行viewdidAppear")
//         setMiniPlayer()
//         sleep(10)
//         popupMusicName = "123"
//         popupMusicAuthor = "123"
//         setMiniPlayer()
//         print("viewdidAppear 结束")
//        sleep(10)
//    }
    
    
//    func setMiniPlayer(){
//        print("执行setMiniPlayer")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let demoVC = storyboard.instantiateViewController(withIdentifier: "playerVC")
//
//        self.popupNextButtonItem = UIBarButtonItem(image: UIImage(systemName: "forward.fill"), style: .plain, target: nil, action: nil)
//        self.popupPlayButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: nil, action: nil)
//
//
//        self.musicImage = UIImage.init(named: "genre1")
//
//        self.popupBar.barStyle = .prominent
//
//        demoVC.popupItem.title = self.popupMusicName
//        demoVC.popupItem.subtitle = self.popupMusicAuthor
////        print(demoVC.popupItem.title!)        //can receive value correctly
////        print(demoVC.popupItem.subtitle!)     //can receive value correctly
//        //demoVC.popupItem.progress = 0.34
//        self.popupItem.trailingBarButtonItems = [self.popupNextButtonItem!]
//        demoVC.popupItem.leadingBarButtonItems = [self.popupPlayButtonItem!]
//        demoVC.popupItem.image = musicImage
//
//        self.presentPopupBar(withContentViewController: demoVC, animated: true, completion: nil)
//
//        print("执行setMiniPlayer完成")
//        print("当前值为")
//        print(demoVC.popupItem.title!)        //can receive value correctly
//        print(demoVC.popupItem.subtitle!)     //can receive value correctly
//        self.loadView()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
