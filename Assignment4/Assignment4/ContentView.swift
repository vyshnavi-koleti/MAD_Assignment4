//
//  ContentView.swift
//  Assignment4
//
//  Created by Vyshnavi Koleti on 9/21/23.
//

import SwiftUI

struct Country: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var capital: [String]?
    var flag: String
    var population: Int
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct ContentView: View {
    
    @State var countries =  [Country]()
    
    func getAllCountries() async -> () {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationView {
            List(countries) { country in
                VStack(alignment: .leading) {
                    
                    Text("\(country.name.common) ")
                        .font(.title)
                    HStack{
                        
                        Text("\(country.flag) \(country.population)")
                            .font(.subheadline)
                        
                    }
                    
                }
                //                    Button("\(country.flag) • \(country.name.common)"){
                //                        showingAlert = true
                //                    }
                //                    .alert(isPresented: $showingAlert) {
                //                        Alert(title: Text("\(country.name.common)"), message: Text("\(country.population)"), dismissButton: .default(Text("Got it!")))
            }
            .task {
                await getAllCountries()
            }
            
        }
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
