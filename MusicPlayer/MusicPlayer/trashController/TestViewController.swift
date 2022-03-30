//
//  TestViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/4/6.
//

import UIKit
import LNPopupController
class TestViewController: UIViewController {
    var popupNextButtonItem: UIBarButtonItem?
    var popupPlayButtonItem: UIBarButtonItem?
    var musicImage: UIImage?
    
    @IBOutlet weak var tabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let demoVC = storyboard.instantiateViewController(withIdentifier: "playerVC")
        
        self.popupNextButtonItem = UIBarButtonItem.init(title: "111", style: .plain, target: self, action: nil)
        self.popupPlayButtonItem = UIBarButtonItem.init(title: "222", style: .plain, target: self, action: nil)
        self.musicImage = UIImage.init(named: "play")
        //self.view.addSubview(button)
        self.popupBar.barStyle = .prominent
        demoVC.popupItem.title = "Hello World"
        demoVC.popupItem.subtitle = "And a subtitle!"
        demoVC.popupItem.progress = 0.34
        demoVC.popupItem.trailingBarButtonItems = [self.popupNextButtonItem!]
        demoVC.popupItem.leadingBarButtonItems = [self.popupPlayButtonItem!]
        demoVC.popupItem.image = musicImage
        
        self.presentPopupBar(withContentViewController: demoVC, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override var bottomDockingViewForPopupBar: UIView? {
      return tabBar
    }

    override var defaultFrameForBottomDockingView: CGRect {
      var bottomViewFrame = tabBar.frame


        //bottomViewFrame.origin = CGPoint(x: bottomViewFrame.minX, y: view.bounds.height)

        bottomViewFrame.origin = CGPoint(x: bottomViewFrame.minX, y: view.bounds.height - 150)


      return bottomViewFrame
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
