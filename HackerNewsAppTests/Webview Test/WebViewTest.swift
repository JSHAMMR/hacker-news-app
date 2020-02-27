//
//  WebViewTest.swift
//  HackerNewsAppTests
//
//  Created by Gamil Ali Qaid Shamar on 12/02/2020.
//  Copyright © 2020 Jamil. All rights reserved.
//

import XCTest
import WebKit
@testable import HackerNewsApp

// moke provider for WKNavigationDelegate
class WebMock:NSObject, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        expectation.fulfill()
        finish = true
    }
    var expectation:XCTestExpectation!
    var finish = false
}
class WebViewTest: XCTestCase {

    fileprivate var webDetail:WebDetail!
    var expectation:XCTestExpectation!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.webDetail = (WebDetail.instanceFromNib() as! WebDetail)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //
    func testWebView() {
        let webMock = WebMock()
        expectation = XCTestExpectation(description: "loading webview") // wait 10 sec
        webMock.expectation = expectation
        self.webDetail.webView.load(URLRequest(url: URL(string: "https://blog.roboflow.ai/self-driving-car-dataset-missing-pedestrians/")!))
        self.webDetail.webView.navigationDelegate = webMock // listen to webview update
        wait(for: [expectation], timeout: 20.0) // not more than 10 sec
        XCTAssertTrue(webMock.finish,"Falied to load webview") 
    }

}
