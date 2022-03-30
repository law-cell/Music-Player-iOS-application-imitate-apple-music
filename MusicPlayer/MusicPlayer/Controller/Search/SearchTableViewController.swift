//
//  SearchTableViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/2.
//

import UIKit
import LeanCloud

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    var num1: Int = 1
    var music = [Music]()
    var music1 = [LCObject]()
    var testWord: String = "未改变"
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSearchTable), name: NSNotification.Name(rawValue: "refreshSearchTable"), object: nil)
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return music1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        let this_music = music1[indexPath.row]
        cell.musicName.text = this_music.get("musicName")?.stringValue
//        cell.musicName.text = testWord
        cell.musicAuthor.text = this_music.get("musicAuthor")?.stringValue
        let musicData = this_music.get("musicImage") as? LCObject
            
        let url = URL(string: (musicData?.url?.stringValue)!)
        let data = try? Data(contentsOf: url!)
        cell.musicImage.image = UIImage(data: data!)
        
        

            
            let query3 = LCQuery(className: "UserMusicMap")
            let music = LCObject(className: "Music", objectId: this_music.objectId!)
            let user = LCObject(className: "_User", objectId: CurrentUser.userId)
            query3.whereKey("user", .equalTo(user))
            query3.whereKey("music", .equalTo(music))
            _ = query3.find { result in
                switch result {
                case .success(objects: let students):
                    if students.count != 0{
                        cell.addMusicButton.isHidden = true
                    }else{
                        cell.addMusicButton.isHidden = false
                    }
                    break
                case .failure(error: let error):
                    print(error)
                }
            }
            
            
            
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let demoVC = storyboard.instantiateViewController(withIdentifier: "playerVC") as! PlayerViewController
        demoVC.popupItem.title = cell.musicName.text!
        demoVC.popupItem.subtitle = cell.musicAuthor.text!
        demoVC.popupItem.image = cell.musicImage.image
        
        //let playerView = PlayerViewController()
        demoVC.musicName = cell.musicName.text!
        demoVC.musicAuthor = cell.musicAuthor.text!
        demoVC.musicImage = cell.musicImage.image!
        SongsViewController.currentPlayingIndexpath = 0
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeObserver"), object: nil)
        tabBarController?.presentPopupBar(withContentViewController: demoVC, animated: true, completion: nil)
        musicPlayer.findUrlByNameAndPlay(musicName: cell.musicName.text!)
        
        

        

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        testWord = searchText
        
        if searchText == ""{
            print("空")
            self.music1.removeAll()
            self.tableView.reloadData()
        }else{
        let query = LCQuery(className: "Music")
        query.whereKey("musicName", .matchedSubstring(searchText))
        _ = query.find { result in
            switch result {
            case .success(objects: let musics):
                // students 是包含满足条件的 Student 对象的数组
                //print(musics.count)

                
                print(musics.count)
                self.music1 = musics
                self.tableView.reloadData()


                break
            case .failure(error: let error):
                print(error)
            }
        }
        }
        

        
    }
    
    @objc func refreshSearchTable(){
        self.tableView.reloadData()
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
