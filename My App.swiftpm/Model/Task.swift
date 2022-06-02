import SwiftUI

struct Poop: Identifiable{
    var id = UUID().uuidString
    var time: Date = Date()
    var description : String = ""
//    var didPoop : Bool = false
//    var ratePoop : String = ""
//    var color : String = ""
//    var size : String = ""
//    var shape : String = ""
}


struct PoopMetaData: Identifiable{
    var id = UUID().uuidString
    var poop: [Poop]
    var poopDate: Date
}

func getSamplePoopDate(offset: Int)->Date{
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var poops: [PoopMetaData] = [
    PoopMetaData(poop: [Poop(description: "My stomach was really hurting this morning, and I haven't pooped for a few days. I can really feel my mental health taking a toll, too, as I was super irritable.")], poopDate: getSamplePoopDate(offset: 8)),
    PoopMetaData(poop: [Poop(description: "I went on keto and the antinflammatory diet is really helping me poop consistenly. Its not long snakes, but snakes.")], poopDate: getSamplePoopDate(offset: 7)),
    PoopMetaData(poop: [Poop(description: "The carnivore diet is really helping me poop a lot, and my cravings are all gone!")], poopDate: getSamplePoopDate(offset: 6)),
    PoopMetaData(poop: [Poop(description: "I am taking haritaki and castor oil like the doctor told me, and its really helping!")], poopDate: getSamplePoopDate(offset: 5)),
    PoopMetaData(poop: [Poop(description: "The carnivore diet is really helping me poop a lot, and my cravings are all gone!")], poopDate: getSamplePoopDate(offset: 4)),
    PoopMetaData(poop: [Poop(description: "I'm eating too much sugar lately, since grandma came, and everything feels so blocked")], poopDate: getSamplePoopDate(offset: 3)),
    PoopMetaData(poop: [Poop(description: "The carnivore diet is really helping me poop a lot, and my cravings are all gone!")], poopDate: getSamplePoopDate(offset: 2)),
    

]


//PoopMetaData(poop: [Poop(notes: "I drank castor oil last nigt and did a salt flush so I flushed my stomach! Thank god", didPoop: true, ratePoop: "10", color: "brown", size: "large", shape: "snake")], poopDate: getSamplePoopDate(offset: 10)),
//PoopMetaData(poop: [Poop(notes: "My stomach was really hurting this morning, and I haven't pooped for a few days. I can really feel my mental health taking a toll, too, as I was super irritable.", didPoop: true, ratePoop: "10", color: "brown", size: "large", shape: "type 2")], poopDate: getSamplePoopDate(offset: 10))
