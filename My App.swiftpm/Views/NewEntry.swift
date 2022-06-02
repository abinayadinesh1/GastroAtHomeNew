import SwiftUI

struct newEntryView: View{
    @State var didPoop : Bool = false
    @State var ratePoop : String = "0"
    @State var color : String = ""
    @State var size : String = ""
    @State var shape : String = ""
    @State var notes : String = ""
    @State var time : Date = Date()
    
    @State private var colorIndex : Int = 0
    var colorSelection = ["brown", "green", "red", "pale", "yellowish"]
    
    var body: some View{
        Form{                
                Section(header: Text("Description")){
                Toggle(isOn: $didPoop){
                    Text("Pooped?")
                }
            }                
                Section(header: Text("Rate your poop on a scale from 1-10 (10 being best)")){
                    TextField("5", text: $ratePoop).keyboardType(.decimalPad)
                }
            Section(){
                Picker(selection: $colorIndex, label: Text("Color")){
                    ForEach(0 ..< colorSelection.count){
                        Text(self.colorSelection[$0])
                    }
                }
            }
            
            Section(header: Text("Extra")){
                TextEditor(text: $notes)
            }
            Button{
                PoopMetaData(poop: [Poop(description: self.notes)], poopDate: getSamplePoopDate(offset: 10))
                
            } label: {
                Text("Submit Entry").frame(width: 250, height: 50, alignment: .center).foregroundColor(.white).background(Color(.systemBlue)).cornerRadius(10)
            }
            Image("poopChart").resizable().frame(width: .infinity, height: 300, alignment: .leading)
            
        }
        
    }
    
}


//did u poop toggle?
//how would you rate the poop?
// what color/size/shape was the poop (dropdown selector)
//
