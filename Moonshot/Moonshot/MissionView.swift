//
//  MissionView.swift
//  Moonshot
//
//  Created by Dave Spina on 12/14/20.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let allMissions: [Mission]
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.allMissions = Bundle.main.decode("missions.json")
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}) {
                let cm = CrewMember(role: member.role, astronaut: match)
                matches.append(cm)
            } else {
                fatalError("Astronaut was not found.")
            }
        }
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                GeometryReader { imgGeo in
                    VStack(alignment: .center) {
                        Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .accessibility(label: Text("\(self.mission.displayName)"))
                        .accessibilityRemoveTraits(.isImage)
                            .frame(maxWidth:  imgGeo.frame(in: .global).maxY - (geo.size.height / 16.0) < geo.size.width * 0.6 ? geo.size.width * 0.6 :  imgGeo.frame(in: .global).maxY - (geo.size.height / 16.0))
                        .padding(.top)
                    }
                    .frame(width: geo.size.width)
                }
                Text(self.mission.launcDateDisplay)
                    .accessibility(label: Text("Launch Date: \(self.mission.launcDateDisplay)"))
                Text(self.mission.description)
                    .padding()
                ForEach(self.astronauts, id: \.role) {crewmember in
                    NavigationLink(destination: AstronautView(astronaut: crewmember.astronaut, missions: allMissions)) {
                        HStack(alignment: .top) {
                            Image(crewmember.astronaut.id)
                                .resizable()
                                .frame(width: 83, height: 70)
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(crewmember.role == "Commander" ? Color.yellow : Color.primary, lineWidth: 2)
                                )
                                .accessibility(label: Text(crewmember.astronaut.name))
                                .accessibilityRemoveTraits(.isImage)
                            
                            VStack(alignment: .leading) {
                                Text(crewmember.astronaut.name)
                                    .font(.headline)
                                HStack {
                                    Text(crewmember.role)
                                        .foregroundColor(.secondary)
                                    if crewmember.role == "Commander" {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .accessibility(label: Text("Commander"))
                                            .accessibilityRemoveTraits(.isImage)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibility(hint: Text("Click for astronaut details"))
                    .accessibilityAddTraits(.isButton)
                }
                
                Spacer(minLength: 25)
                
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
