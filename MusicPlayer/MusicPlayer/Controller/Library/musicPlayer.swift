//
//  musicPlayer.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/4/27.
//

import Foundation
import AVFoundation
import LeanCloud

class musicPlayer {
    static var testValue:String?
    static var playerItem:AVPlayerItem?
    static var avplayer:AVPlayer?
    static var playerLayer:AVPlayerLayer?
    static var isPlaying:Bool = false

    
    static func findUrlByNameAndPlay(musicName:String){
        let query = LCQuery(className: "_File")
        var url: String?
        query.whereKey("name", .equalTo(musicName+".mp3"))
        _ = query.find { result in
            switch result {
            case .success(objects: let musics):
                // musics 是包含满足条件的 Music 对象的数组
                url = musics[0].url?.stringValue
                print(url!)
                guard let url = NSURL(string: url!) else { fatalError("连接错误") }

                playerItem = AVPlayerItem(url: url as URL) // 创建视频资源
                // 将视频资源赋值给视频播放对象
                avplayer = AVPlayer(playerItem: playerItem)
                // 初始化视频显示layer
                playerLayer = AVPlayerLayer(player: avplayer)
                avplayer?.play()
                musicPlayer.isPlaying = true
                musicPlayer.changeImageFromleadingButton()
                musicPlayer.changeProgressInBigPlayer()
                break
            case .failure(error: let error):
                print(error)
            }
        }
    }
    
    static func playAndPauseOfLeadingButton(){   
        print(isPlaying)
        if isPlaying == true {
            avplayer?.pause()
            musicPlayer.isPlaying = false
            musicPlayer.changeImageFromleadingButton()
        }else{
            avplayer?.play()
            musicPlayer.isPlaying = true
            musicPlayer.changeImageFromleadingButton()
        }
    }
    

    
    static func changeImageFromleadingButton(){
        PlayerViewController.popupPlayButtonItem?.image = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
    }
    
    static func changeProgressInBigPlayer(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeProgress"), object: nil)
    }
}
