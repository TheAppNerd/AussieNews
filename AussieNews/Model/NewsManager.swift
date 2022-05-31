//
//  NewsManager.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit

class NewsManager {

    // MARK: - Properties

    let baseURL              = "https://api.newscatcherapi.com/v2/"
    let headlines            = "latest_headlines?lang=en&countries=au&topic=politics"
    let topicURL             = "latest_headlines?lang=en&countries=au&topic="
    let searchURL            = "&countries=au&lang=en"
    var topic: String        = ""
    var searchString: String = ""
    let searchLink           = "search?q="

    enum networkParams {
        case home
        case topic
        case search
    }

    // MARK: - Singleton

    static let Shared = NewsManager()
    private init () {}

    // MARK: - Functions

    /// Method to parse news data depending on specified endoints
    ///
    /// - Parameter: networkParams: the specific type of use the user is after. Eg/ home page, specific topic or search query
    func getNews(params: networkParams, completed: @escaping (Result<Articles, NewsErrors>) -> Void) {
        let encodedSearchString = searchString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        var endpoint: String = ""

        switch params {
        case .home:
            endpoint = baseURL + headlines
        case .topic:
            endpoint = baseURL + topicURL + topic
        case .search:
            endpoint = baseURL + searchLink + encodedSearchString + searchURL
        }

        guard let url = URL(string: endpoint) else {
            completed(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(APIKey().apiKey, forHTTPHeaderField: "x-api-key")

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



    /// Method to cache downloaded images.
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cache    = NSCache<NSString, UIImage>()
        let cacheKey = NSString(string: urlString)

        // Pulls image from cache if it exists there.
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        // Confirms URL is valid.
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        // Pulls the data from the URL, confirms the request worked and image is valid, sets teh image in cache and returns image.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response   = response as? HTTPURLResponse, response.statusCode == 200,
                  let data       = data,
                  let image      = UIImage(data: data),
                  error          == nil
            else {
                let placeholderImage = Images.placeholder
                completed(placeholderImage)
                return
            }
            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completed(image)
            }
        }
        task.resume()
    }
    
}

