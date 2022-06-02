import SwiftUI
import UIKit

struct CustomDatePicker: View{
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0 //allow month to update on arrow button
    public var screenWidth = UIScreen.main.bounds.width
    public var screenHeight = UIScreen.main.bounds.height
    public var calendar = Calendar.current
    var body: some View{
        
        VStack(alignment: .leading, spacing: 20){
            let days : [String] = ["Sun", "Mon","Tue", "Wed", "Thurs", "Fri", "Sat"]
            HStack{
                HStack(spacing: 10){    
                    Text(dateHeader()[0]).bold().font(.system(size: 35))
                }.frame(width: screenWidth/7, alignment: .leading).position(x: screenWidth/12.5, y:screenHeight/22)
                VStack{
                    Button("Today") {
                        currentMonth=0
                    }.foregroundColor(.red)
                    HStack{
                        Button {
                            currentMonth-=1
                        } label: { 
                            Image(systemName: "chevron.left.square.fill").resizable().scaledToFit().frame(width: screenWidth/75).foregroundColor(.red)
                        }
                        Button {
                            currentMonth+=1
                        } label: { 
                            Image(systemName: "chevron.right.square.fill").resizable().scaledToFit().frame(width: screenWidth/75).foregroundColor(.red)
                        }
                    }
                    
                }.padding(.top, screenHeight/32).padding(.trailing,25)}
            
            HStack(spacing:0){
                ForEach(days, id: \.self){day in 
                    Text(day).font(.callout).fontWeight(.semibold).frame(maxWidth: .infinity)
                }
            }
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) { 
                ForEach(extractDates()){value in
                    CardView(value: value).background(
                        Capsule().fill(.pink).padding(.horizontal, 8).opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0 )
                    ).onTapGesture{currentDate = value.date}
                }
                
            }.onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
            VStack(spacing: 20){
                Text("Entries").font(.title2.bold()).frame(maxWidth: .infinity, alignment: .leading)
                if let poop = poops.first(where: {poop in 
                    return isSameDay(date1: poop.poopDate, date2: currentDate)
                }){
                    ForEach(poop.poop){poop in 
                        VStack(alignment: .leading, spacing: 10){
                            Text(poop.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .date).font(.title3.bold()).padding(.top,10)
                            Text(poop.description).font(.body).padding(.bottom, 10)
                        }.padding(.horizontal).frame(maxWidth: .infinity, alignment: .leading).border(.brown).cornerRadius(10).padding()                    }
                    
                }else{
                    Text("No entries found! Add a new one.")
                }
            }.padding()
        }.padding(.top, 10)
        
    }
    @ViewBuilder
    func CardView(value: DateValue)-> some View{
        VStack{
            if value.day != -1{
                if let poop = poops.first(where: {poop in 
                    return isSameDay(date1: poop.poopDate, date2: value.date)
                }){
                    Text("\(value.day)").foregroundColor(isSameDay(date1: poop.poopDate, date2: currentDate) ? .white : .primary).frame(maxWidth: .infinity)
                    Spacer()
                    Circle().fill(isSameDay(date1: poop.poopDate, date2: currentDate) ? Color(.red) : Color(red: 0.6, green:0.34117647058, blue:0.31764705882)).frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)").foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary).frame(maxWidth: .infinity)
                    Spacer()
                }
                
            }
        }
    }
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func dateHeader()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: "")
    }
    
    
    
    func getCurrentMonth()-> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else{
            return Date()
        }
        return currentMonth
        
    }
    
    
    func extractDates()->[DateValue]{
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap{date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from:days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday-1{
            days.insert(DateValue(day:-1, date: Date()), at:0)
        }
        return days
    }
    
}
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.compactMap{day -> Date in 
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
