//
//  Library.swift
//  Video Game Library iOS
//
//  Created by Gabriela Torres on 10/29/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import Foundation

class Library {
    //Singleton!
    static let sharedInstance = Library()
    
    var games = [Game]()
}
