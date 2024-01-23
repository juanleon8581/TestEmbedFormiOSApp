//
//  ContentView.swift
//  TestApp
//
//  Created by Juan Pablo Leon on 22/01/24.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var showWebView = false
    private let pmData = "Host App"
    
    private let url = "http://localhost:3001"
    
    var body: some View {
        VStack(){
            //Link(destination: URL(string: url)!, label: {
                Text(pmData)
            //})
            
            /*Button("new tap in app"){
                showWebView = true
            }.sheet(isPresented: $showWebView){
                WebView(urlString: url)
            }*/
        }
        VStack(content: {
            WebView(urlString: url)
        })
    }
}

#Preview {
    ContentView()
}
