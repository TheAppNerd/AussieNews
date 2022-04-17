//
//  NewsManager.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit

class NewsManager {
    
    let baseURL = "https://api.newscatcherapi.com/v2/"
    let headlines = "latest_headlines?lang=en&countries=au&topic=entertainment"
    let topicURL = "latest_headlines?lang=en&countries=au&topic="
    let searchURL = "&countries=au&lang=en"
    var topic: String = ""
    var searchString: String = ""
    
    enum networkParams {
        case home
        case topic
        case search
    }
    
    static let Shared = NewsManager()
    
    private init () {}
    
  
    let cache = NSCache<NSString, UIImage>()
    
    func getNews(params: networkParams, completed: @escaping (Result<Articles, NewsErrors>) -> Void) {
        let urlString = searchString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        var endpoint: String = ""
        
        switch params {
        case .home:
            endpoint = baseURL + headlines
    
        case .topic:
            endpoint = baseURL + topicURL + topic
        
        case .search:
        endpoint = baseURL + "search?q=" + urlString! + searchURL
        }

        guard let url = URL(string: endpoint) else {
            completed(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
       
        //hide this key
        request.addValue("-4JjtRyAm4l4Djwgl2VpVmsE1LXUtLBHeeUdaCOF41g", forHTTPHeaderField: "x-api-key")



        let task = URLSession.shared.dataTask(with: request) { data, response, error in

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

