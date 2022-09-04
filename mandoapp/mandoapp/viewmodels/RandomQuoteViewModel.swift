//
//  RandomQuoteViewModel.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/18/22.
//
// ViewModels in the app

import Foundation
import os

@MainActor class RandomQuoteViewModel: ObservableObject {
    @Published var randomQuote: (String, String) = ("", "")
    @Published var errorGotten: Error?
    let logger = Logger(subsystem: "com.mandoapp.RandomQuoteViewModel", category: "fetchrandomquotes" )
    
    init(){
        Task {
            do {
                let quote = try await fetchRandomQuote()
                randomQuote = (quote.0, quote.1)
            } catch {
                let errorDes = error.localizedDescription
                logger.log("Error occured: \(errorDes)")
                errorGotten = error
            }
        }
    }
    

    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    /// fetch the random quote from the API
    /// I chose not to create a custom struct, but to pass the result as a tuple of two Strings instead.
    /// First String: the content of the quote
    /// Second String: the person who said it
    
    func fetchRandomQuote() async throws -> (String, String)  {
        guard let url = URL(string: "https://officeapi.dev/api/quotes/random") else {
            fatalError("Invalid URL!")
        }
        let(data, _) = try await URLSession.shared.data(from:url)
        let randomQuote = try JSONDecoder().decode(QuoStr.self, from: data)
        let quote = randomQuote.data // Extract needed information
        let sent = quote.content
        let personFN = quote.character.firstname
        let personLN = quote.character.lastname
        let person = personFN + " " + personLN // Put the first name and last name together, since the seperation of them is not relevant for this task
        logger.log("Generated a random Office quote")
        return (sent, person)
    }
}
