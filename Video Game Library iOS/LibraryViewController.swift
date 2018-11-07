//
//  LibraryViewController.swift
//  Video Game Library iOS
//
//  Created by Gabriela Torres on 10/29/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    
    
    let library = Library.sharedInstance
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.emptyDataSetSource = self
        self.TableView.emptyDataSetDelegate = self
           library.games.append(Game(
           title: "Blah", description: "whatever", rating: .everyone, genre: .horror))

        TableView.tableFooterView = UIView()
        TableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        TableView.reloadData()
    }
}


extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LibraryCell
        
        let game = library.games[indexPath.row]
        cell.setupGame(game: game)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
//            Library.sharedInstance.games.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//
//        let game = library.games[indexPath.row]
//
//        return [deleteAction]
//    }
    
    //Check out game
    func checkOut(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.availability = .checkOut(dueDate: dueDate)
        (TableView.cellForRow(at: indexPath) as! LibraryCell).setupGame(game: game)
    }
    //Check In game
    func checkIn(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.availability = .checkIn
        (TableView.cellForRow(at: indexPath) as! LibraryCell).setupGame(game: game)
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //This deletes a game
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let game = library.games[indexPath.row]
        
        //Adding the ability to swipe left on a cell to check it in and out or delete it
        switch game.availability {
        case .checkIn:
            let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                
                self.checkOut(at: indexPath)
                
            }
            return [deleteAction, checkOutAction]
            
        case .checkOut:
            let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                self.checkIn(at: indexPath)
            }
            
            return [deleteAction, checkInAction]
            
        }
    }
}


//This will show if you don’t have any games in the library
extension LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString! {
        return NSAttributedString(string: "Empty Library")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString! {
        return NSAttributedString(string: "You haven't added any games to your library.")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString! {
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: .bold)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
    }
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        performSegue(withIdentifier: "LibraryToAddGame", sender: self)
    }
}
