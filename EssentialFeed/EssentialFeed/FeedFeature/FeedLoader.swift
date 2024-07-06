//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Vetri Thiyagu on 25/06/24.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
