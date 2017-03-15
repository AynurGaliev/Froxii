//
//  Friends.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

let NYLocation = CLLocation(latitude: 40.71, longitude: -74.01)

enum Gender: Int {
    case male = 0
    case female
    
    var annotationImage: UIImage {
        switch self {
            case .male   : return Gender.maleAnnotationImage
            case .female : return Gender.femaleAnnotationImage
        }
    }
    
    static let maleAnnotationImage   : UIImage = UIImage.from(color: UIColor.blue, size: CGSize(width: 4, height: 4)) //UIImage(named: "male_annotation")!
    static let femaleAnnotationImage : UIImage = UIImage.from(color: UIColor.red, size: CGSize(width: 4, height: 4)) //UIImage(named: "female_annotation")!
}

struct Friend {
    
    let name       : String
    let surname    : String
    let gender     : Gender
    let location   : CLLocation
    let isMyFriend : Bool
    
    static func getRandomFriends(count: Int = 30) -> [Friend] {
        
        let names: [String] = ["John", "Joshua", "Jayden", "Christopher", "Michael", "Ethan", "Logan", "Samuel", "Elijah", "James", "Joseph", "William", "David", "Gabriel", "Jacob", "Alexander", "Daniel", "Angel", "Anthony", 	"Aiden", "Jose"]
        let surnames: [String] = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson"]
        
        var friends: [Friend] = []
        
        for _ in 0..<count {
            let name    : String = names[self.getRandomInt(min: 0, max: names.count - 1)]
            let surname : String = surnames[self.getRandomInt(min: 0, max: surnames.count - 1)]
            let gender  : Gender = Gender(rawValue: self.getRandomInt(min: 0, max: 1))!
            let location: CLLocation = self.getRandomLocation()
            let isMyFriend: Bool = self.getRandomBool()
            let friend  : Friend = Friend(name: name, surname: surname, gender: gender, location: location, isMyFriend: isMyFriend)
            friends.append(friend)
        }
        return friends
    }
    
    static func getRandomLocation() -> CLLocation {
        var delta = Double(arc4random())/Double(UINT32_MAX)
        let latitudeDelta: Double = -1 + 2 * delta
        delta = Double(arc4random())/Double(UINT32_MAX)
        let longitudeDelta: Double = -1 + 2 * delta
        return CLLocation(latitude: NYLocation.coordinate.latitude + latitudeDelta,
                         longitude: NYLocation.coordinate.longitude + longitudeDelta)
    }
    
    static func getRandomBool() -> Bool {
        return Int(arc4random_uniform(2)) == 0
    }
    
    static func getRandomInt(min: Int, max: Int) -> Int {
        let randomDouble: Double = Double(arc4random())/Double(UINT32_MAX)
        let value = Double(min) + Double(max + min) * randomDouble
        return Int(round(value))
    }
}
