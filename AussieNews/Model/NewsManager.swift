//
//  NewsManager.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit

class NewsManager {
    
    static let Shared = NewsManager()
    
    private init () {}

    let baseURL = "https://api.newscatcherapi.com/v2/search?q=Tesla"
    
    
    func getNews(completed: @escaping (Result<Articles, NewsErrors>) -> Void) {

    //let endpoint = baseURL + "/v2/search?q=Apple&from='2021/12/15'&countries=CA&page_size=1"

        guard let url = URL(string: baseURL) else {
            completed(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
       
        //hide this key
        request.addValue("9IdSOBlQI3mUlrru9-qShsYwhy1qWjrPfcTRm9M7r10", forHTTPHeaderField: "x-api-key")



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

}
