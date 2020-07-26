//
//  NewsFeed.swift
//  tldr_content
//
//  Created by Nicholas on 7/25/20.
//  Copyright © 2020 Lux Grey. All rights reserved.
//

import UIKit

protocol NewsFeedDelegate {
    func didUpdateNews(news: [NewsData])
}

class NewsFeed {
    
    var delegate: NewsFeedDelegate?
    
    func news() {
        let headers = [
            "x-rapidapi-host": "newscafapi.p.rapidapi.com",
            "x-rapidapi-key": "cddb6af78fmshd194980a96ca25fp15090djsn909f7d10bcb8"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://newscafapi.p.rapidapi.com/apirapid/news/technology/?q=news")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
                return
            }
            if let safeData = data {
                if let news = self.parseJSON(newsData: safeData) {
                        self.delegate?.didUpdateNews(news: news)
                }
            }
        })
        
        dataTask.resume()
        
    }
    
    func parseJSON(newsData: Data) -> [NewsData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([NewsData].self, from: newsData)
            
            return decodedData
        }   catch {
            return nil
        }
    }
    
}
