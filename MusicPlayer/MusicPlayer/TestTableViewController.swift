//
//  TestTableViewController.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/23.
//

import UIKit

class TestTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)

        // Configure the cell...

        return cell
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
       let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
       let delete = UIAlertAction(title: "Delete", style: .default) {
           (action: UIAlertAction) -> Void in
           
           let alertC = UIAlertController(title: nil, message: "Delete?", preferredStyle: .alert)
           let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            //self.remove(at: indexPath.row)
               //self.jobsTableView.reloadData()
               
               
               
           }
           alertC.addAction(ok)
           let back = cancel
           alertC.addAction(back)
           self.present(alertC, animated: true, completion: nil)
           
       }
       
       ac.addAction(cancel)
       present(ac, animated: true, completion: nil)
       ac.addAction(delete)
       
       tableView.deselectRow(at: indexPath, animated: true)

        

        
        
    }
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
