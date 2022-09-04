//
//  CharViewModel.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/24/22.
//

import Foundation
import os

@MainActor class CharViewModel: ObservableObject {
    @Published var randomChar: String = ""
    @Published var date = Date()
    @Published var isDone: Bool = false
    @Published var counter: Int = 0
    @Published var errorGotten: Error?
    @Published var name: String = ""
    let logger = Logger(subsystem: "com.mandoapp.CharViewModel", category: "fetchrandomchar" )

    
    init(){
        Task {
            do {
                self.randomChar = try await fetchRandomChar()
            } catch {
                let errorDes = error.localizedDescription
                logger.log("Error occured: \(errorDes)")
                errorGotten = error
            }
        }
    }
    
    /// fetch the random character from the API
    func fetchRandomChar() async throws -> String  {
        guard let url = URL(string: "https://officeapi.dev/api/characters/random") else {
            fatalError("Invalid URL!")
        }
        let(data, _) = try await URLSession.shared.data(from:url)
        let randomChar = try JSONDecoder().decode(CharStr.self, from: data)
        let char = randomChar.data
        let personFN = char.firstname
        let personLN = char.lastname
        let person = personFN + " " + personLN
        logger.log("Random character fetched.")
        return person
    }
}
