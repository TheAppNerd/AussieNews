//
//  NewsManager.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit

class NewsManager {
    
    let apiKey = "&apiKey=a1c9799d78c040df82b183e5ccae527f"
    let baseURL = "https://newsapi.org/v2/top-headlines?country=au&pagesize=100&category="
    
    var newsArticles: [Article] = []
    var businessArticles: [Article] = []
    var entertainmentArticles: [Article] = []
    var generalArticles: [Article] = []
    var healthArticles: [Article] = []
    var scienceArticles: [Article] = []
    var sportsArticles: [Article] = []
    var technologyArticles: [Article] = []
    
    

    static let Shared = NewsManager()
    
    private init () {}
    
    let cache = NSCache<NSString, UIImage>()
    
    
    
    func getNews(topic: String, completed: @escaping (Result<Articles, NewsErrors>) -> Void) {
        let endpoint: String = baseURL + topic + apiKey
    
        guard let url = URL(string: endpoint) else {
            completed(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.urlError))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.urlError))
                return
            }

            guard let data = data else {
                completed(.failure(.responseError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let newsArticles = try decoder.decode(Articles.self, from: data)
                completed(.success(newsArticles))
            } catch {
                completed(.failure(.decodeError))
            }
        }
        task.resume()
}
    
    
    
    //fix this up
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }

    
}
