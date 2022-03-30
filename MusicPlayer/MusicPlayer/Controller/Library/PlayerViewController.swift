//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/4/25.
//

import UIKit
import LNPopupController
import AVFoundation
import LeanCloud

class PlayerViewController: UIViewController {

    
    static var popupNextButtonItem: UIBarButtonItem?
    static var popupPlayButtonItem: UIBarButtonItem?
    var musicName: String = ""
    var musicAuthor: String?
    var musicImage:UIImage?
    var timeObserverToken: Any?

    


    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var musicAuthorLabel: UILabel!
    @IBOutlet weak var playerViewPlayingButton: UIButton!

    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var musicVoiceSlider: UISlider!
    @IBOutlet weak var currentTimeLable: UILabel!
    @IBOutlet weak var totalTimeLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBigPlayerButton()
        musicNameLabel?.text = musicName
        musicAuthorLabel?.text = musicAuthor
        musicImageView?.image = musicImage
        musicSlider.value = 0

        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshButton), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPeriodicTimeObserver), name: NSNotification.Name(rawValue: "changeProgress"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removePeriodicTimeObserver), name: NSNotification.Name(rawValue: "removeObserver"), object: nil)
        //更改button的通知
        

//        print(musicNameLabel?.text)

        
        PlayerViewController.popupNextButtonItem = UIBarButtonItem(image: UIImage(systemName: "forward.fill"), style: .plain, target: self, action: #selector(self.nextMusicByPopupNextButtonItem))

        PlayerViewController.popupPlayButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(self.playMusicByPopupPlayButtonItem))
        PlayerViewController.popupNextButtonItem?.tintColor = UIColor.black
        PlayerViewController.popupPlayButtonItem?.tintColor = UIColor.black
        
        self.popupItem.trailingBarButtonItems = [PlayerViewController.popupNextButtonItem!]
        self.popupItem.leadingBarButtonItems = [PlayerViewController.popupPlayButtonItem!]

        // Do any additional setup after loading the view.
    }
    

    
    
    @objc public func playMusicByPopupPlayButtonItem()  {
    
        
        musicPlayer.playAndPauseOfLeadingButton()

        
    }
    
    @objc public func nextMusicByPopupNextButtonItem() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "next"), object: nil)
    }
    
    @IBAction func playMusicByBigPlayerButton(_ sender: Any) { //大播放器播放按钮
        musicPlayer.playAndPauseOfLeadingButton()


    }
    
    
    @IBAction func nextMusicByBigPlayerButton(_ sender: Any) { //大播放器下一曲按钮
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "next"), object: nil)
    }
    
    
    @IBAction func backwardMusicByBigPlayerButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backward"), object: nil)//大播放器上一曲按钮
    }
    
    func changeBigPlayerButton(){

        playerViewPlayingButton?.setImage(UIImage(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill"),for: .normal)
    }

    
    @objc func refreshButton(notification: NSNotification) {

        self.changeBigPlayerButton()
        
    }
    

    
    @objc func addPeriodicTimeObserver() {
        // 每半秒查看
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        timeObserverToken = musicPlayer.avplayer!.addPeriodicTimeObserver(forInterval: time,queue: .main) {[weak self] time in
            // update player transport UI
            
            let songcurrent = musicPlayer.avplayer!.currentTime().seconds

            
            let duration = musicPlayer.avplayer!.currentItem?.asset.duration
            let songtotal = CMTimeGetSeconds(duration!)

            
            let currenttotal:Float = Float(songcurrent / songtotal)
            
            let songcurrentInt = Int(songcurrent)
            let songtotalInt = Int(songtotal)
            
            if  songcurrentInt < 60 && songcurrentInt >= 10{
                let time = "0" + ":" + songcurrentInt.stringValue!
                self!.currentTimeLable.text = time
            }else if songcurrentInt < 10 {
                let time = "0" + ":" + "0" + songcurrentInt.stringValue!
                self!.currentTimeLable.text = time
            }else{
                let minutes = Int(songcurrentInt / 60)
                let seconds = songcurrentInt % 60
                let time = minutes.stringValue!+":"+seconds.stringValue!
                self!.currentTimeLable.text = time
            }
            
            if songtotalInt < 60{
                let time = "0" + ":" + songtotalInt.stringValue!
                self!.totalTimeLable.text = time
            }else{
                let minutes = Int(songtotalInt / 60)
                let seconds = songtotalInt % 60
                let time = minutes.stringValue!+":"+seconds.stringValue!
                self!.totalTimeLable.text = time
            }
            
            
            self!.musicSlider.value = currenttotal

        }
    }
    
    @objc func removePeriodicTimeObserver() {// 移除Observe，每次
            if let timeObserverToken = timeObserverToken {
                musicPlayer.avplayer!.removeTimeObserver(timeObserverToken)
                self.timeObserverToken = nil
            }
        }
    

    @IBAction func musicSliderButton(_ sender: Any) {
        let songcurrent = musicSlider.value

        let duration = musicPlayer.avplayer!.currentItem?.asset.duration
                let songtotal = CMTimeGetSeconds(duration!)
                let songtotalFloat = Float(songtotal)
                
                let songhahqa = Int(songtotalFloat * songcurrent)
                let time = CMTime(value: CMTimeValue(songhahqa), timescale: 1)
                musicPlayer.avplayer!.seek(to: time)
            }
    
    
    @IBAction func voiceSliderButton(_ sender: Any) {
        let volume = musicVoiceSlider.value
        musicPlayer.avplayer!.volume = volume
    }
    
}
