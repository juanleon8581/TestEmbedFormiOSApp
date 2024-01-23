# Embed our form with a webview in a Swift App

To use our form in your native iOS application, you first need a WebView. You can find the official documentation for this component here.
[https://developer.apple.com/documentation/webkit/wkwebview](https://developer.apple.com/documentation/webkit/wkwebview)

Here is a simple usage example.

1. Create a Swift file named "WebView" in your project.
2. Insert the following code

```swift
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
	//Insert Code Here
}
```

3. Now, in the WebView block, we need to create some classes, functions and variables.

```swift
let urlString: String // Here we receive the url to load in the WebView container
```

```swift
//Here we can receive a process our postMessage
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
						//Here you can process the message 
						//and continue with the flow of your app
        }
    }
}

func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
}
```

```swift
//In this block we are going to create and configure our WebView container
//For more configuration details, 
//please refer to the offitial configuration at the top of the document.

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
```

4. Now we go to our ViewComponent and add the new WebView componet

```swift
struct ContentView: View {
    private let title = "Host App" //text without importance
    private let url = "http://localhost:3001" //Replace by the URL you need
    
    var body: some View {
				//This block is for illustrative purposes only; in this example, 
				//this block represents the host application.
        VStack(){
            Text(title)
        }
				//This block is the call to the VebView
        VStack(content: {
            WebView(urlString: url)
        })
    }
}
```
