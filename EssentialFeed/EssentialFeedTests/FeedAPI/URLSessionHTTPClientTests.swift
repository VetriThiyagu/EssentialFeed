//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Vetri Thiyagu on 07/07/24.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: URLRequest(url: url)) { _, _, _ in }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_createsDataTaskWithURL() {
        let request = URLRequest(url: URL(string: "https://any-url.com")!)
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: request.url!)
        
        XCTAssertEqual(session.receivedURLs, [request.url!])
    }
    
    func test_getFromURL_resumesDataTaskWithURL() {
        let request = URLRequest(url: URL(string: "https://any-url.com")!)
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: request.url!, task: task)
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: request.url!)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        var receivedURLs = [URL]()
        private var stub = [URL: URLSessionDataTask]()
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(request.url!)
            return stub[request.url!] ?? FakeURLSessionDataTask()
        }
        
        func stub(url: URL, task: URLSessionDataTask) {
            stub[url] = task
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }
}
