//
//  ContentView.swift
//  TabViewsandLabels
//
//  Created by cecily li on 10/12/22.
//

import SwiftUI

//A tab view allows for switching between multiple child views using user interface elements
//
struct ContentView: View {
    var body: some View {
        TabView {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
        }
        //.tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
