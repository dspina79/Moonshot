//
//  AstronautView.swift
//  Moonshot
//
//  Created by Dave Spina on 12/14/20.
//

import SwiftUI

struct AstronautView: View {
    struct MissionMember {
        var mission: Mission
        var role: String
    }
    
    let astronaut: Astronaut
    var missionDetails: [MissionMember]
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missionDetails = [MissionMember]()
        for mission in missions {
            if let cm = mission.crew.first(where: {$0.name == self.astronaut.id}) {
                let mm = MissionMember(mission: mission, role: cm.role)
                self.missionDetails.append(mm)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    VStack {
                        Image(self.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                        Text(self.astronaut.description)
                            .padding()
                        Text("Missions")
                            .font(.subheadline)
                        ForEach(self.missionDetails, id: \.mission.id) { md in
                            HStack(spacing: 10) {
                                Image(md.mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    
                                VStack {
                                    Text("\(md.mission.displayName)")
                                    Text("\(md.mission.launcDateDisplay)")
                                }
                                Text(md.role)
                                    .padding()
                            }.padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
            
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
