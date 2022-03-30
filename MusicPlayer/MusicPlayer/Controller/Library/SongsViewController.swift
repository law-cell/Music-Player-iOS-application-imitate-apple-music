//
//  SongsViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/3/29.
//

import UIKit
import LeanCloud
import AVFoundation



class SongsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    

    let playerView = PlayerViewController()
    let player = musicPlayer()
    
    static var numberOfRows:Int = 0
    var music1 = [LCObject]()
    var musicSearchResults = [LCObject]()
    static var currentPlayingIndexpath:Int?
    var num1: Int?
    
    var musicList = [LCObject]()

    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var songsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    
    var playerItem:AVPlayerItem!
    var avplayer:AVPlayer!
    var playerLayer:AVPlayerLayer!
    let studname = {(val1: Int) -> Int in
        return val1
     }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(simulateSelectRow), name: NSNotification.Name(rawValue: "next"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backwardMusic), name: NSNotification.Name(rawValue: "backward"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
        //下一曲的通知
        songsTable.delegate = self
        songsTable.dataSource = self
        searchBar.delegate = self
        playButton.layer.cornerRadius = 10
        shuffleButton.layer.cornerRadius = 10
        
        //SongsViewController.numberOfRows = 0
        searchBar(searchBar, textDidChange: "")//先执行一次，让列表显示所有喜爱歌曲
        
               
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//
//        //实际上赋值成功，只是函数结束后才会调用，所以这里print不出值
//
////        return query.count().intValue
//        let query = LCQuery(className: "UserMusicMap")
//        if CurrentUser.islogin == true{
//
//        let user = LCObject(className: "_User", objectId: CurrentUser.userId)
//
//        query.whereKey("music", .included)// 重点！！！ pointer查询需要 included 属性名， 不是所指向的表名字
//        //query.whereKey("_User", .included)
//        query.whereKey("user", .equalTo(user))
//        _ = query.find { (result) in
//                switch result {
//                    case .success(objects: let studentCourseMaps):
//                        print(studentCourseMaps)
//                        SongsViewController.numberOfRows = studentCourseMaps.count
//                        self.music1 = studentCourseMaps
//                        print(SongsViewController.numberOfRows)
//
//                    case .failure(error: let error):
//                        print(error)
//                }
//            }
//            return query.count().intValue
//        }
//
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("在numberOfRowsInSection数字是：")
        print(self.musicSearchResults.count)
        //return SongsViewController.numberOfRows
        return self.musicSearchResults.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songsCell", for: indexPath) as! SongsTableViewCell
        
        let this_music = musicSearchResults[indexPath.row]
        let query = LCQuery(className: "Music")
        let _ = query.get((this_music.objectId?.stringValue)!) { (result) in
            switch result {
            case .success(object: let music):
                cell.musicName.text  = music.get("musicName")?.stringValue
                cell.musicAuthor.text  = music.get("musicAuthor")?.stringValue
            
                let musicData = music.get("musicImage") as? LCObject
            
                let url = URL(string: (musicData?.url?.stringValue)!)
                let data = try? Data(contentsOf: url!)
                cell.musicImage.image = UIImage(data: data!)
            case .failure(error: let error):
                print(error)
            }
        }
        


//        let user = LCObject(className: "_User", objectId: CurrentUser.userId)
//        let query = LCQuery(className: "UserMusicMap")
//        query.whereKey("music", .included)// 重点！！！ pointer查询需要 included 属性名， 不是所指向的表名字
//        query.whereKey("user", .equalTo(user))
//        _ = query.find { (result) in
//                        switch result {
//                            case .success(objects: let studentCourseMaps):
//                                //print(studentCourseMaps)
//
////                                self.music1 = studentCourseMaps
////                                print(SongsViewController.numberOfRows)
//                                for i in self.music1{
//                                    let this_music = studentCourseMaps[indexPath.row]
//                                    let music = this_music["music"] as? LCObject
//                                    if i.objectId == music?.objectId{
//
//                                        //print(SongsViewController.numberOfRows)
//                                        //print("成功")
//                                    cell.musicName.text  = music?.get("musicName")?.stringValue
//                                    cell.musicAuthor.text  = music?.get("musicAuthor")?.stringValue
//
//                                    let musicData = music!.get("musicImage") as? LCObject
//
//                                    let url = URL(string: (musicData?.url?.stringValue)!)
//                                    let data = try? Data(contentsOf: url!)
//                                    cell.musicImage.image = UIImage(data: data!)
//                                    }else{
//                                        //print("失败")
//                                    }
//                                }
//
//                            case .failure(error: let error):
//                                print(error)
//                        }
//                    }

        
        
        
        
        return cell
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "songsCell", for: indexPath) as! SongsTableViewCell
//
//        let query = LCQuery(className: "UserMusicMap")
//        let user = LCObject(className: "_User", objectId: CurrentUser.userId)
//
//
//        query.whereKey("music", .included)// 重点！！！ pointer查询需要 included 属性名， 不是所指向的表名字
//        //query.whereKey("_User", .included)
//        query.whereKey("user", .equalTo(user))
//        _ = query.find { (result) in
//                switch result {
//                    case .success(objects: let studentCourseMaps):
//
//                        SongsViewController.numberOfRows = studentCourseMaps.count
//                        let this_music = studentCourseMaps[indexPath.row]
//
//                            print((this_music.objectId?.stringValue)!)
//                        let music = this_music["music"] as? LCObject
//                            cell.musicName.text  = music?.get("musicName")?.stringValue
//                            cell.musicAuthor.text  = music?.get("musicAuthor")?.stringValue
//                            print(music?.get("musicName")?.stringValue)
//                                            let musicData = music!.get("musicImage") as? LCObject
//
//                                            let url = URL(string: (musicData?.url?.stringValue)!)
//                                            let data = try? Data(contentsOf: url!)
//                                            cell.musicImage.image = UIImage(data: data!)
//
//
//                    case .failure(error: let error):
//                        print(error)
//                }
//            }
//
//        // Configure the cell...
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("You selected cell \(indexPath.row)")
        SongsViewController.currentPlayingIndexpath = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as! SongsTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let demoVC = storyboard.instantiateViewController(withIdentifier: "playerVC") as! PlayerViewController
        demoVC.popupItem.title = cell.musicName.text!
        demoVC.popupItem.subtitle = cell.musicAuthor.text!
        demoVC.popupItem.image = cell.musicImage.image
        
        //let playerView = PlayerViewController()
        demoVC.musicName = cell.musicName.text!
        demoVC.musicAuthor = cell.musicAuthor.text!
        demoVC.musicImage = cell.musicImage.image!
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeObserver"), object: nil)
        tabBarController?.presentPopupBar(withContentViewController: demoVC, animated: true, completion: nil)
        musicPlayer.findUrlByNameAndPlay(musicName: cell.musicName.text!)
        
        

        

        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("搜索框变动")
        SongsViewController.numberOfRows = 0
        self.musicSearchResults.removeAll()
        print("音乐数量归零成功")
        //objc_sync_enter(self)
        let query = LCQuery(className: "Music")
        query.whereKey("musicName", .matchedSubstring(searchText))
        _ = query.find { result in
            switch result {
            case .success(objects: let musics):
                // students 是包含满足条件的 Student 对象的数组
                //print(musics.count)
               
                
               // print(musics.count)
                self.music1 = musics
                //self.songsTable.reloadData()
                
                let user = LCObject(className: "_User", objectId: CurrentUser.userId)
                let query = LCQuery(className: "UserMusicMap")
                query.whereKey("music", .included)// 重点！！！ pointer查询需要 included 属性名， 不是所指向的表名字 		
                query.whereKey("user", .equalTo(user))
                _ = query.find { (result) in
                                switch result {
                                    case .success(objects: let studentCourseMaps):
                                        //print(studentCourseMaps)
                                        self.musicSearchResults.removeAll()
        //                                self.music1 = studentCourseMaps
        //                                print(SongsViewController.numberOfRows)
                                        if studentCourseMaps.count != 0{
                                        for i in 0...studentCourseMaps.count-1{
                                            for j in self.music1{
                                            let this_music = studentCourseMaps[i]
                                            let music = this_music["music"] as? LCObject
                                            if j.objectId == music?.objectId{
                                                SongsViewController.numberOfRows += 1
                                                print(SongsViewController.numberOfRows)
                                                let musicRearchResult = LCObject(className: "Music", objectId: (music?.objectId?.stringValue)!)
                                                
                                               
                                                
                                                self.musicSearchResults.append(musicRearchResult)
                                               
                                            }else{
                                                
                                            }
                                        }
                                        }
                                            
                                        self.songsTable.reloadData()
                                        }
                                    case .failure(error: let error):
                                        print(error)
                                }
                            }

                
                break
            case .failure(error: let error):
                print(error)
            }
        }
        
        //objc_sync_exit(self)
        
        
    }
    
    @IBAction func ClickPlayButton(_ sender: Any) {
        if CurrentUser.islogin == true{
        let path:IndexPath!
        path = IndexPath(row: 0,section: 0)
        self.songsTable.selectRow(at: path, animated: true, scrollPosition: .top)
        tableView(songsTable, didSelectRowAt: path)
        //不会自动调用delegate的方法，所以需要增加上面这行代码
        }
    }
    
    @IBAction func ClickShuffleButton(_ sender: Any) {
        if CurrentUser.islogin == true{
        let path:IndexPath!
            print(self.musicSearchResults.count)
            path = IndexPath(row: Int(arc4random_uniform(UInt32(musicSearchResults.count-1))),section: 0)
        self.songsTable.selectRow(at: path, animated: true, scrollPosition: .top)
        tableView(songsTable, didSelectRowAt: path)
        //不会自动调用delegate的方法，所以需要增加上面这行代码
        }
    }
    
    
    @objc func simulateSelectRow(){//小型播放器的下一曲按钮
        
        
        if CurrentUser.islogin == true{
        print("当前播放的序列")
        print(SongsViewController.currentPlayingIndexpath)
        let path:IndexPath!
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeObserver"), object: nil)
        print("当前列表歌曲数")
        print(SongsViewController.numberOfRows)
        if SongsViewController.currentPlayingIndexpath != SongsViewController.numberOfRows-1{
             path = IndexPath(row: SongsViewController.currentPlayingIndexpath!+1, section: 0)
        }else{
             path = IndexPath(row: 0,section: 0)
        }
        	
        self.songsTable.selectRow(at: path, animated: true, scrollPosition: .top)
        tableView(songsTable, didSelectRowAt: path)
        //不会自动调用delegate的方法，所以需要增加上面这行代码
        }
    }
        
    
    @objc func backwardMusic(){
        if CurrentUser.islogin == true{
        let path:IndexPath!
        if SongsViewController.currentPlayingIndexpath != 0{
             path = IndexPath(row: SongsViewController.currentPlayingIndexpath!-1, section: 0)
        }else{
            path = IndexPath(row: SongsViewController.numberOfRows-1,section: 0)
        }
            
        self.songsTable.selectRow(at: path, animated: true, scrollPosition: .top)
        tableView(songsTable, didSelectRowAt: path)
        }
    }
    
    @objc func refreshView(){
        searchBar(searchBar, textDidChange: "")
        songsTable.reloadData()
    }

}
