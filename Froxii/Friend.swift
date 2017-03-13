//
//  Friends.swift
//  Froxii
//
//  Created by Aynur Galiev on 13.03.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import CoreLocation

let NYLocation = CLLocation(latitude: 40.71, longitude: -74.01)

enum Gender: Int {
    case Male = 0
    case Female
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
            let name    : String = names[Int(arc4random_uniform(UInt32(names.count)))]
            let surname : String = surnames[Int(arc4random_uniform(UInt32(surnames.count)))]
            let gender  : Gender = Gender(rawValue: Int(arc4random_uniform(1)))!
            let location: CLLocation = self.getRandomLocation()
            let isMyFriend: Bool = NSNumber(value: Int(arc4random_uniform(1))).boolValue
            let friend  : Friend = Friend(name: name, surname: surname, gender: gender, location: location, isMyFriend: isMyFriend)
            friends.append(friend)
        }
        return friends
    }
    
    static func getRandomLocation() -> CLLocation {
        var delta = Double(arc4random()/UINT32_MAX)
        let latitudeDelta: Double = -1 + 2 * delta
        delta = Double(arc4random()/UINT32_MAX)
        let longitudeDelta: Double = -1 + 2 * delta
        return CLLocation(latitude: NYLocation.coordinate.latitude + latitudeDelta,
                         longitude: NYLocation.coordinate.longitude + longitudeDelta)
    }
}
