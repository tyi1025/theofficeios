//
//  CrewView.swift
//  mandoapp
//  Gives an overview of crew members
    
//  Created by Tianyi Wang on 4/19/22.
//

import SwiftUI


struct CrewView: View {
    @StateObject var crewViewModel = CrewViewModel()
    
    var body: some View {
        VStack{
            List {
                ForEach(crewViewModel.crewLs, id: \.id) { crew in
                    HStack{
                        Text(crew.name)
                        Spacer()
                        Text(crew.role)
                    }
                }


                }
            if let error = crewViewModel.errorGotten {
                Text(error.localizedDescription)
            }
            }.backgroundViewModifier()
            .navigationBarTitle("List of crew members")
            

        }
    }



struct CrewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CrewView()
        }
    }
}
