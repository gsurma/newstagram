//
//  ApiManager.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation

final class ApiManager {
    
    static let sharedInstance = ApiManager()
    
    var dataTask: URLSessionDataTask?
    
    func getHeadlines(category: String, locale: String, completion: @escaping (_ articles: [Article])->()) {
        
        dataTask?.cancel()

        if var urlComponents = URLComponents(string: apiHost + "top-headlines") {
            let query = "country=\(locale.lowercased())&apiKey=" + apiKey + "&category=" + category.lowercased() + "&pageSize=" + apiPageSize
            urlComponents.query = query
            guard let url = urlComponents.url else { return }
            dataTask = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                    if let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                            if let dict = self.getDictionaryFromJSON(data: data) as [String: Any]? {
                                completion(self.parseArticles(dict: dict))
                            }
                    } else {
                        print("Error: \(String(describing: error))")
                        completion([])
                }
            }
            dataTask?.resume()
        }
    }
    
    private func parseArticles(dict: [String: Any]) -> [Article] {
        var articles = [Article]()
        if let articleDicts = dict["articles"] as? Array<[String: Any]> {
            for articleDict in articleDicts {
                if let article = Article(dict: articleDict) as Article? {
                    articles.append(article)
                }
            }
        }
        return articles
    }
    
    private func getDictionaryFromJSON(data: Data) -> [String: Any]? {
        if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return dict
        }
        return nil
    }
}
