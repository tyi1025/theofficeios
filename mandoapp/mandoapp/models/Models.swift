//
//  RandomQuote.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/18/22.
//
// Models for custom data types in the app

import Foundation

struct Quote: Decodable {
    var _id: String
    var content: String
    var character: Character
}

struct Character: Decodable {
    var _id: String
    var firstname: String
    var lastname: String
}


struct QuoStr: Decodable {
    var data: Quote
}

struct CharStr: Decodable {
    var data: Character
}

struct Crew: Identifiable, Decodable {
    let id: String
    var name: String
    var role: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        
        case name
        case role
    }
}


struct CrewStr: Decodable{
    var data: Crew
}

struct CrewsStr: Decodable {
    var data: [Crew]
}
