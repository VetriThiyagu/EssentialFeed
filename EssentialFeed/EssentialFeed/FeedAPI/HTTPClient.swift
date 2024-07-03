//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Vetri Thiyagu on 03/07/24.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
