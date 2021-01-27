import SwiftUI

struct ContentView: View {
    @State private var showMissionDates = false
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(self.missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    HStack(alignment: .top){
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .accessibility(hidden: true)
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            if showMissionDates {
                                Text(mission.launcDateDisplay)
                                    .accessibility(label: Text("Launch Date  \(mission.launcDateDisplay)"))
                            } else {
                                Text(getCrewMembers(mission))
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading:
                Button("\(self.showMissionDates ? "Show Crew Members" : "Show Mission Dates")", action: {
                    self.showMissionDates.toggle()
                })
                                    .accessibility(hint: Text("Toggle crew member or mission displays."))
            )
            .navigationBarTitle("Moonshot")
            
        }
        
    }
    
    func getCrewMembers(_ mission: Mission) -> String {
        var astros = ""
        for c in mission.crew {
            for a in astronauts {
                if a.id == c.name {
                    astros += "\n\(a.name)"
                }
            }
        }
        return astros
    }
    
    func methodA() -> String {
        return "Hello World!"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
