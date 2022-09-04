//
//  MainView.swift
//  mandoapp
//
//  Created by Tianyi Wang on 4/18/22.
//
// Gives the view of the app when started.

import SwiftUI



struct StartView: View {
    @StateObject var randomQuoteViewModel = RandomQuoteViewModel()
    
    var body: some View {
        NavigationView{
        VStack{
            
            Text("Welcome to The Office (US) wiki").font(.custom("Cafe Matcha", size: 25))
            
            Text("Your Office quote for today: ")

            if let quote = randomQuoteViewModel.randomQuote{
            Text("\"" + quote.0 + "\"")
                Text("-- " + quote.1)

            } else {
                if let error = randomQuoteViewModel.errorGotten {
                    Text(error.localizedDescription)
                }
                
            }

            
            NavigationLink(destination: CrewView(), label: {Label("See the list of crew members", systemImage: "person.3.fill")})
                .buttonStyle(BlueButton())
            NavigationLink(destination: CharView(), label: {Label("Find out which Office character you would be!", systemImage: "person.fill")} )
                .buttonStyle(BlueButton())
            AsyncImage(url: URL(string: "https://i.stack.imgur.com/V5PSe.jpg")){ image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
             .frame(maxWidth: 400, maxHeight: 400)
            
        }.backgroundViewModifier()
        }
        
        }
    }


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()

        }
    }
}


struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
