//
//  GameClass.swift
//  Video Game Library iOS
//
//  Created by Gabriela Torres on 10/29/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import Foundation

class Game {
    //Genre of game
    enum Genre: String {
        case action = "Action"
        case RPG = "RPG" //Role-Playing Game
        case adventure = "Adventure"
        case horror = "Horror"
    }
    //Rating of game
    enum Rating: String {
        case kids = "Kids" //K
        case everyone  = "Everyone"//E
        case teen  = "Teens"//T
        case mature  = "Mature" //M
        case adultsOnly = "Adults Only" //AO
        case notRated  = "Not Rated" //NR
    }
    //Availability if game is checked in or checked out
    enum Availability {
        case checkIn
        case checkOut(dueDate: Date)
        init(date: Date?) {
            if let date = date {
                self = .checkOut(dueDate: date)
            } else {
                self = .checkIn
            }
        }
    }
    
    var title: String
    var description: String
    var rating: Rating
    var genre: Genre
    var availability: Availability
        
    
    init(title: String, description: String, rating: Rating, genre: Genre) {
        self.title = title
        self.description = description
        self.rating = rating
        self.genre = genre
        self.availability = .checkIn
    }
}


