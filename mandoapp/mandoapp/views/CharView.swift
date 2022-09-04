//
//  CharView.swift
//  mandoapp
//
// This functionailty is semantically nonsense. It receives the user's input information and randomly gives them an Office character.
//  Created by Tianyi Wang on 4/19/22.
//


import SwiftUI
import ConfettiSwiftUI


struct CharView: View {
    @StateObject var charViewModel = CharViewModel()


    
    var body: some View {
        VStack{
            Text("Enter your name and birthday to find out which The Office character you would be!").font(Font.system(size: 25, weight: .bold))
            Form {
                TextField("Enter your full name", text: $charViewModel.name)
                DatePicker(
                    "Enter your birthday",
                    selection: $charViewModel.date,
                    displayedComponents: [.date]
                )
                
            }

            Text("Your Office character would be: ")

            Button(action: {
                charViewModel.isDone.toggle()
                charViewModel.counter += 1
            }) { Text(charViewModel.isDone ? "Ta-da! " : "Find out!")}.buttonStyle(BlueButton())
            
            if charViewModel.isDone {
                if let error = charViewModel.errorGotten {
                    Text(error.localizedDescription)
                }
                Text(charViewModel.randomChar)
            } else {
                Text("")
            }
            
            }.backgroundViewModifier()
            .confettiCannon(counter: $charViewModel.counter)
        }
        

}


struct CharView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharView()
        }
    }
}

// error message for empty name/invalid birthday?
