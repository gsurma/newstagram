//
//  Article.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation

struct Article {
    
    let url: String
    let urlToImage: String
    let title: String
    
    let source: Source?
    let author: String?
    let description: String?
    let publishedAt: String?
    
    init?(dict: [String: Any]) {
        if let title = dict["title"] as? String,
            let urlToImage = dict["urlToImage"] as? String,
            let url = dict["url"] as? String {
            self.title = title
            self.urlToImage = urlToImage
            self.url = url
            self.author = dict["author"] as? String
            self.description = dict["description"] as? String
            self.publishedAt = dict["publishedAt"] as? String
            if let sourceDict = dict["source"] as? [String: Any] {
                self.source = Source(dict: sourceDict)
            } else {
                self.source = nil
            }
        } else {
            return nil
        }
    }
}

struct Source {
    let id: String
    let name: String
    
    init?(dict: [String: Any]) {
        if let id = dict["id"] as? String,
            let name = dict["name"] as? String {
            self.id = id
            self.name = name
        } else {
            return nil
        }
    }
}
