import SwiftUI

struct ContentView: View {
    @State var currentDate: Date = Date()
    var body: some View {
        ScrollView{
            // spacing between objects in the stack
            VStack (spacing: 10){
                CustomDatePicker(currentDate: $currentDate).padding(.vertical)
            }
        }
        .safeAreaInset(edge: .bottom) { 
            HStack{
                Button{
                    newEntryView()
                } label:{
                    Text("Add New Entry").fontWeight(.bold).padding(.vertical).frame(maxWidth: .infinity)
                }
//                Button{
//                    
//                } label:{
//                    Text("Add Reminder").fontWeight(.bold).padding(.vertical).frame(maxWidth: .infinity).background(Color("Orange"), in: Capsule())
//                }
            }
        }
    }
}


    
