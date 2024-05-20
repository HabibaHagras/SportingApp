//
//  LeagueTableViewController.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import SDWebImage

class LeagueTableViewController: UITableViewController {
    var homeViewModel:HomeViewModel?
    var nameSport:String?
    var leagueName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
           homeViewModel = HomeViewModel()
         homeViewModel?.fetchLeaguesViewModel(for: nameSport!)
        
        
                    homeViewModel?.bindResultToViewController = {
                    [weak self] in
                    DispatchQueue.main.async {
                        print(self?.homeViewModel?.LeagueResultVar as? [League])
                        self?.tableView!.reloadData()
                    }
                    
                }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leagues"
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeViewModel?.LeagueResultVar?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        let currentLeague =  homeViewModel?.LeagueResultVar?[indexPath.item]
      if let logoURLString = currentLeague?.leagueLogo, let logoURL = URL(string: logoURLString) {
            cell.imgLeague.sd_setImage(with: logoURL, completed: nil)
        } else {
            cell.imgLeague.image = UIImage(named: "d") 
        }
        cell.labelLeagueCell.text = currentLeague?.leagueName
        
        return cell
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
