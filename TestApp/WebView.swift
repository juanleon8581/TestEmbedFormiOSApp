//
//  WKwebView.swift
//  TestApp
//
//  Created by Juan Pablo Leon on 22/01/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
    
    let urlString: String
    
        
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
            var parent: WebView

            init(parent: WebView) {
                self.parent = parent
            }

            // Handle messages received from JavaScript
            func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
                // Process the message received from JavaScript
                if let messageBody = message.body as? String {
                    print("Message from WebView: \(messageBody)")
                }
            }
        }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
    
    func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            webView.navigationDelegate = context.coordinator

            // Add a script message handler to listen for messages from JavaScript
            let userContentController = webView.configuration.userContentController
            userContentController.add(context.coordinator, name: "swiftMessageHandler")

            // Load a sample HTML file
            if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
                let htmlUrl = URL(fileURLWithPath: htmlPath)
                let htmlString = try? String(contentsOf: htmlUrl, encoding: .utf8)
                webView.loadHTMLString(htmlString ?? "", baseURL: Bundle.main.bundleURL)
            }
        

            return webView
        }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

