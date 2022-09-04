//
//  CrewViewModel.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/24/22.
//

import Foundation
import os

@MainActor class CrewViewModel: ObservableObject {
    @Published var crewLs:[Crew] = []
    @Published var errorGotten: Error?
    let logger = Logger(subsystem: "com.mandoapp.CrewViewModel", category: "fetchcrew")
    
    init(){
        Task {
            do {
                self.crewLs = try await fetchCrew()
            } catch {
                let errorDes = error.localizedDescription
                logger.log("Error occured: \(errorDes)")
                errorGotten = error
            }
        }
    }
    
    /// Fetch the crew list from the API
    func fetchCrew() async throws -> [Crew] {
        guard let url = URL(string: "https://officeapi.dev/api/crew/") else {
            fatalError("Invalid URL!")
        }
        let(data, _) = try await URLSession.shared.data(from:url)
        let crewsLs = try JSONDecoder().decode(CrewsStr.self, from: data)
        let crews = crewsLs.data
        
        
        
        return crews
        }
    
}
