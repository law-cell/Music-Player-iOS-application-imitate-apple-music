//
//  SongsTableViewCell.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/3/30.
//

import UIKit
import LeanCloud

class SongsTableViewCell: UITableViewCell, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
        }
    }
    

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicAuthor: UILabel!
    @IBOutlet weak var musicName: UILabel!
    
    func createContextMenu() -> UIMenu {
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            print("Share")
            print(self.musicName.text!)
        }
        
        let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
            print("Copy")
        }
        
        let deleteFromLibrary = UIAction(title: "Delete From Library", image: UIImage(systemName: "trash")) { _ in
            
            let alert = UIAlertController(title: nil, message: "Are you sure you want to delete this song from your Library? This would also remove it from any playlist.", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Delete Song", style: .default, handler: { action in
                let query = LCQuery(className: "Music")
                query.whereKey("musicName", .equalTo(self.musicName.text!))
                query.whereKey("musicAuthor", .equalTo(self.musicAuthor.text!))
                _ = query.find { result in
                    switch result {
                    case .success(objects: let music):
                        print("找到的musicID:")
                        print((music[0].objectId?.stringValue)!)
                        print("找到的userID")
                        print(CurrentUser.userId)
                        let query2 = LCQuery(className:"UserMusicMap")
                        let user = LCObject(className: "_User", objectId: CurrentUser.userId)
                        let music = LCObject(className: "music", objectId: music[0].objectId!)
                        query2.whereKey("music", .equalTo(music))
                        query2.whereKey("user", .equalTo(user))
                        _ = query2.find { result in
                            switch result {
                            case .success(objects: let map):
                                print("找到的mapID:")
                                print(map[0].objectId!)
                                let userMusicMap = LCObject(className: "UserMusicMap", objectId: map[0].objectId!)
                                _ = userMusicMap.delete { result in
                                    switch result {
                                    case .success:
                                        print("删除成功")
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshTable"), object: nil)
                                        break
                                    case .failure(error: let error):

                                        print(error)
                                        print("失败")
                                    }
                                }


                                break
                            case .failure(error: let error):
                                print(error)
                            }
                        }

                        break
                    case .failure(error: let error):
                        print(error)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        
        }
        
        return UIMenu(title: "", children: [shareAction, copy, deleteFromLibrary])
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
        self.isUserInteractionEnabled = true
        
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

}
