//
//  ContentView.swift
//  Moonshot
//
//  Created by Dave Spina on 12/12/20.
//

import SwiftUI

struct Person: Codable {
    var name: MyName
    var address: MyAddress
}

struct MyName: Codable {
    var firstName: String
    var lastName: String
}

struct MyAddress: Codable {
    var street: String
    var city: String
    var state: String
    var postalCode: String
}

struct SampleDetailDisplay: View {
    var number: Int
    var text: String
    
    var body: some View {
        VStack {
            Button("Test Data") {
                let myJSON = """
                {
                    "name": {
                        "firstName": "Dean",
                        "lastName": "Anips"
                    },
                    "address": {
                        "street": "123 Anywhere Drive",
                        "city": "Aberdeen",
                        "state": "NJ",
                        "postalCode": "08172"
                    }
                }
                """
                let data = Data(myJSON.utf8)
                let decoder = JSONDecoder()
                do {
                    let myPerson = try decoder.decode(Person.self, from: data)
                        print("\(myPerson.address.street)")
                } catch let error {
                    print("Nope! \(error.localizedDescription)")
                }
            }
            Text("Details for \(text)")
                .font(.largeTitle)
            Image(systemName: "\(number > 40 ? 0 : number).circle.fill")
                .frame(width: 30, height: 30)
                .foregroundColor(.green)
                
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                List(0..<20) { row in
                    NavigationLink(destination: SampleDetailDisplay(number: row, text: "Detail Main \(row)")) {
                            Text("Item \(row)")
                    }
                }
            }.navigationBarTitle(Text("Nav View"))
        }
        /*
        ScrollView {
            VStack {
                GeometryReader { geo in
                    Image("swiftlogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipped()
                }
                
                ForEach(0..<100) {
                    Text("Item \($0)")
                }
            }.frame(maxWidth: .infinity)
        }
            */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
