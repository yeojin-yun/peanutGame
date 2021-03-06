//
//  APIManager.swift
//  CollaboGame
//
//  Created by 순진이 on 2022/05/22.
//

import Foundation
import Alamofire

final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func requestMovie(word: String, year: Int, country: String, completion: @escaping (Result<Movie, AFError>) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { fatalError() }
        
        let parameter: Parameters = [
            "query": "\(word)",
            "country" : country,
            "yearfrom": year,
            "yearto" : year
        ]
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "TUWSiHEpK6xMQCi8Jqrq",
            "X-Naver-Client-Secret": "1dLbA5yVLN"
        ]
        
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header).validate(statusCode: 200..<300).responseDecodable(of: Movie.self) { response in
            completion(response.result)
        }
    }
}
