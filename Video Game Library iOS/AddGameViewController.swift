//
//  AddGameViewController.swift
//  Video Game Library iOS
//
//  Created by Gabriela Torres on 10/31/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {

//Outlets/Action for the AddGameViewController 
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DetailsTextView: UITextView!
    @IBOutlet weak var RatingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var PickerView: UIPickerView!
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        super.viewDidLoad()
        
        RatingSegmentedControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            RatingSegmentedControl.insertSegment(withTitle: segment.title, at: index, animated: false)
        }
        
       
        PickerView.dataSource = self
        PickerView.delegate = self
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func AddNewGameTapped(_ sender: Any) {
        tryAddingGame()
        
        guard //Makes sure the variables has values
            
            let title = TitleTextField.text, !title.isEmpty,
            let description = DetailsTextView.text, !description.isEmpty
            
            else {
                //This will pop up an error message that make sure you have everything filled in
                let errorAlert = UIAlertController(title: "Hold Up", message: "Make sure you have all the boxes filled in.", preferredStyle: UIAlertController.Style.alert)
                //Allows you to dismiss the alert
                let dismissAction = UIAlertAction(title: "Okie Dokie", style: UIAlertAction.Style.default, handler: {UIAlertAction in })
                errorAlert.addAction(dismissAction)
                self.present(errorAlert, animated: true, completion: nil) //This makes for a cleaner transition when the error pops up
                return
        }
    }
    
    let segments: [(title: String, rating: Game.Rating)] =
        [("K", .kids),
         ("E", .everyone),
         ("T", .teen),
         ("M", .mature),
         ("AO", .adultsOnly),
         ("NR", .notRated)]
    
    let genreArray = ["Action", "Adventure", "RPG", "Horror"]
    
    let genres: [(title: String, genre: Game.Genre)] =
        [("Action", .action),
         ("RPG", .RPG),
         ("Adventure", .adventure),
         ("Horror", .horror)]
    
    func tryAddingGame() {
        //Title
        guard let title = TitleTextField.text else  {return}
        
        //Details
        guard let details = DetailsTextView.text else {return}
        
        //Rating
        let rating = segments[RatingSegmentedControl.selectedSegmentIndex].rating
        
        //Genre
        let genre = genres[PickerView.selectedRow(inComponent: 0)]
    }
}
    
extension AddGameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent componenet: Int) -> Int {
            return genres.count

        }
        func pickerView(_pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return genres[row].title
    }
}
