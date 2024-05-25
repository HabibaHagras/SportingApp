//
//  FavoriteTableViewController.swift
//  SportingApp
//
//  Created by habiba on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    var favViewModel:FavoriteViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
                super.viewDidLoad()
             favViewModel = DependencyInjector.shared.resolveFavoriteViewModel()

             // Set up the binding closure
             favViewModel.bindResultCoreDataToViewController = { [weak self] in
                 DispatchQueue.main.async {
                     if let news = self?.favViewModel?.news, !news.isEmpty {
                         print("Data fetched successfully")
                     } else {
                         print("No data")
                     }
                     self?.tableView.reloadData() // Reload table view after data is fetched
                 }
             }

             favViewModel.fetchData { error in
                 if let error = error {
                     print("Error fetching data: \(error)")
                 }


           }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        favViewModel = DependencyInjector.shared.resolveFavoriteViewModel()

        // Set up the binding closure
        favViewModel?.bindResultCoreDataToViewController = { [weak self] in
            DispatchQueue.main.async {
                if let news = self?.favViewModel?.news, !news.isEmpty {
                    print (" data")
                } else {
                 print ("No data")
                }
             self?.tableView.reloadData() // Reload table view after data is fetched
            }
        }

        // Fetch data from CoreData
        favViewModel?.fetchData { error in
            if let error = error {
                print("Error fetching data: \(error)")
            }}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("gggggggggggggggggggggggg \(favViewModel?.news.count ?? 0)")

        // #warning Incomplete implementation, return the number of rows
        return favViewModel?.news.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 150
      }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         cell.contentView.layer.borderWidth = 1.0
         cell.contentView.layer.borderColor = UIColor.black.cgColor
     }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        let currentLeague =  favViewModel?.news[indexPath.item]
              
              
//              var placeholderImageName: String
//              if let sportName = nameSport {
//                  switch sportName{
//                  case "football":
//                      placeholderImageName = "fooot"
//                  case "basketball":
//                      placeholderImageName = "basketball_image"
//                  case "cricket":
//                      placeholderImageName = "cricket_image"
//                  default:
//                      placeholderImageName = "tennis_image"
//                  }
//              } else {
//                  placeholderImageName = "tennis_image"
//              }
//
        if let logoURLString = currentLeague!.value(forKey:"leagueLogo") , let logoURL = URL(string: logoURLString as! String) {
                  cell.ImgFav.sd_setImage(with: logoURL, completed: nil)
              } else {
                  cell.ImgFav.image = UIImage(named: "football")
              }
        cell.labelFav.text = currentLeague!.value(forKey:"leagueName")  as? String
              
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
