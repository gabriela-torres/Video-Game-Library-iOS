//
//  LibraryCell.swift
//  Video Game Library iOS
//
//  Created by Gabriela Torres on 11/2/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    //Outlets for the LibraryCell
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var DueDateLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!
    @IBOutlet weak var ViewCell: UIView!
    
    
    
    func setupGame(game: Game) {
        TitleLabel.text = game.title
        GenreLabel.text = game.genre.rawValue
        RatingLabel.text = game.rating.rawValue
        
        switch game.availability {
        case .checkIn:
            // Hide due date
            DueDateLabel.isHidden = true
            //Set view to green
            ViewCell.backgroundColor = .green
            
        case .checkOut(let date):
            //Show due date
            DueDateLabel.isHidden = false
            //Set view to red
            ViewCell.backgroundColor = .red
            //Set dueDate to formatted date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            DueDateLabel.text = dateFormatter.string(from: date)
        }
    }
}
