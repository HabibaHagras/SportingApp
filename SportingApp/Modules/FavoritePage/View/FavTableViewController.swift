//
//  FavTableViewController.swift
//  SportingApp
//
//  Created by habiba on 5/27/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import Reachability

class FavTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var favViewModel:FavoriteViewModel!
    var homeConnection : HomeCollectionViewController?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoFavview: UIView!
  
        override func viewDidLoad() {
            super.viewDidLoad()
                    super.viewDidLoad()
            self.tableView.delegate =  self
            self.tableView.dataSource = self
                 favViewModel = DependencyInjector.shared.resolveFavoriteViewModel()

                 favViewModel.bindResultCoreDataToViewController = { [weak self] in
                     DispatchQueue.main.async {
                         if let news = self?.favViewModel?.news, !news.isEmpty {
                             print("Data fetched successfully")
                            self?.NoFavview.isHidden = true
                            self?.tableView.reloadData()

                         } else {
                             print("No data")
                            self?.NoFavview.isHidden = false

                            self?.updateNoFavViewVisibility()
                            self?.tableView.reloadData()


                        
                         }
                         self?.tableView.reloadData()
                        self?.updateNoFavViewVisibility()

                     }
                 }
      
            favViewModel.bindResultDeleteCoreDataToViewController = { [weak self] in
                 DispatchQueue.main.async {
                print("Data Deleted successfully")
                    let alertController = UIAlertController(title: "Success", message: "Data deleted successfully", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                 self?.tableView.reloadData()
                }
      
            }

                 favViewModel.fetchData { error in
                     if let error = error {
                         print("Error fetching data: \(error)")
                     }
                    self.updateNoFavViewVisibility()


               }
        
        }
       private func updateNoFavViewVisibility() {
                     let hasFavorites = (favViewModel?.news.count ?? 0) > 0
//                NoFavview.isHidden = hasFavorites
                 
            if !hasFavorites {
        
                
                let alertController = UIAlertController(title: "You have no favorite news.", message: nil, preferredStyle: .alert)
                  alertController.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default,handler:nil))
               

                // Present the alert controller
                present(alertController, animated: true, completion: nil)
            }
        }


        override func viewWillAppear(_ animated: Bool) {
            favViewModel = DependencyInjector.shared.resolveFavoriteViewModel()

            favViewModel?.bindResultCoreDataToViewController = { [weak self] in
                DispatchQueue.main.async {
                    if let news = self?.favViewModel?.news, !news.isEmpty {
                        print (" data")
                        self?.NoFavview.isHidden = true
                        self?.tableView.reloadData()


                    } else {
                     print ("No data")
                        self?.NoFavview.isHidden = false

                        self?.updateNoFavViewVisibility()
                        self?.tableView.reloadData()

                    }
                 self?.tableView.reloadData()
                }
            }

            favViewModel?.fetchData { error in
                if let error = error {
                    print("Error fetching data: \(error)")
                }}
        }

        // MARK: - Table view data source

         func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("Data Fetched Counnnt  \(favViewModel?.news.count ?? 0)")

            // #warning Incomplete implementation, return the number of rows
            return favViewModel?.news.count ?? 0
        }
         func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 150
          }

         func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
             cell.contentView.layer.borderWidth = 1.0
             cell.contentView.layer.borderColor = UIColor.black.cgColor
         }
      
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
            let currentLeague =  favViewModel?.news[indexPath.item]
                  
                  
                  var placeholderImageName: String
            if var sportName = currentLeague!.value(forKey:"sportName") as? String {
                      switch sportName{
                      case "football":
                          placeholderImageName = "fooot"
                      case "basketball":
                          placeholderImageName = "basketball_image"
                      case "cricket":
                          placeholderImageName = "cricket_image"
                      default:
                          placeholderImageName = "tennis_image"
                      }
                  } else {
                      placeholderImageName = "tennis_image"
                  }

            if let logoURLString = currentLeague!.value(forKey:"leagueLogo") , let logoURL = URL(string: logoURLString as! String) {
                      cell.imgLeague.sd_setImage(with: logoURL, completed: nil)
                  } else {
                      cell.imgLeague.image = UIImage(named: placeholderImageName)
                  }
            cell.labelLeagueCell.text = currentLeague!.value(forKey:"leagueName")  as? String
                  
                  return cell
        }
        
        
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let reachability = try! Reachability()
                if reachability.connection != .unavailable {
                
                 let storyBoard = UIStoryboard(name: "SecondMain", bundle: nil)

               guard let league = favViewModel?.news[indexPath.item] else { return }
               guard let viewController = storyBoard.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsTableViewController else {
                          print("Could not instantiate view controller with identifier 'leagueDetails'")
                          return
                      }

            viewController.nameSport = league.value(forKey:"sportName") as! String
               viewController.leagueId = league.value(forKey:"leagueKey") as! Int
               viewController.leagueName = league.value(forKey:"leagueName") as! String
               viewController.leagueLogo = league.value(forKey:"leagueLogo") as! String

               print(league.value(forKey:"leagueName") as! String)
                             viewController.modalPresentationStyle = .fullScreen
                            present(viewController, animated: true, completion: nil)
                    } else {
                                                 self.present(showAlert(), animated: true)
                                             }
                     
                        }
                    
           func showAlert() -> UIAlertController{
                    let alert = UIAlertController(title: "Error!", message: "please check your connection and try again later", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default,handler:nil))
                    return alert
                }
      

        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        
        // Override to support editing the table view.
         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let league = favViewModel?.news[indexPath.item]
            if editingStyle == .delete {
                 let alertController = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this league?", preferredStyle: .alert)
                       
                       let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                          
                       }
                       
                       let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                           tableView.performBatchUpdates({
                            self.favViewModel?.delete(item: league!) { error in
                                          if let error = error {
                                              print("Error deleting league: \(error)")
                            }}

                               tableView.deleteRows(at: [indexPath], with: .fade)
                           }, completion: nil)
                       }
                       
                       alertController.addAction(cancelAction)
                       alertController.addAction(deleteAction)
                       
                       present(alertController, animated: true, completion: nil)
              //  tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        
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
