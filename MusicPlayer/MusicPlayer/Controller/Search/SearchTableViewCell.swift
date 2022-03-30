//
//  SearchTableViewCell.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/2.
//

import UIKit
import LeanCloud
class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var musicAuthor: UILabel!
    @IBOutlet weak var addMusicButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: self.layoutMargins.left, y: bounds.height / 2 - 24, width: 48, height: 48)
        imageView?.layer.cornerRadius = 3
        

        
        separatorInset = UIEdgeInsets(top: 0, left: textLabel!.frame.origin.x, bottom: 0, right: 0)
    }

    
    
    @IBAction func clickAddMusicButton(_ sender: Any) {
        print(musicName.text!)
        
        let query = LCQuery(className: "Music")
        query.whereKey("musicName", .equalTo(musicName.text!))
        query.whereKey("musicAuthor", .equalTo(musicAuthor.text!))
        _ = query.find { result in
            switch result {
            case .success(objects: let music):
                
                
                do {
                    let user = LCObject(className: "_User", objectId: CurrentUser.userId)


                    let music = LCObject(className: "Music", objectId: music[0].objectId!)
                    

                    let userMusicMap = LCObject(className: "UserMusicMap")

                    try userMusicMap.set("user", value: user)
                    try userMusicMap.set("music", value: music)
                    


                    _ = userMusicMap.save { result in
                        switch result {
                            case .success:
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshSearchTable"), object: nil)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
                              
                                break
                            case .failure(error: let error):
                                print(error)
                        }
                    }
                } catch {
                    print(error)
                }
                
                break
            case .failure(error: let error):
                print(error)
            }
        }

    }
    
}
