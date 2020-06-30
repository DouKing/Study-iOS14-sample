//
//  ContentView.swift
//  Shared
//
//  Created by DouKing on 2020/6/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                List {
                    NavigationLink(destination: HomeView()) {
                        Text("Navigate")
                    }

                    NavigationLink(destination: ProfileView(), label: {
                        Text("Navigate")
                    })
                }
                .navigationTitle("Home")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }

            NavigationView {
                List {
                    NavigationLink(destination: HomeView()) {
                        Text("Navigate")
                    }
                }
                .navigationTitle("Profile")
            }
            .tabItem {
                Text("Profile")
                Image(systemName: "person")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
