//
//  NYTimesAPI.swift
//  EgymApp
//
//  Created by Nithin Michael on 4/8/22.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum EndPoint {
    case home
    case arts
    case science
    case us
    case world

    var path: String {
        switch self {
        case .home:
            return "home.json"
        case .arts:
            return "arts.json"
        case .science:
            return "science.json"
        case .us:
            return "us.json"
        case .world:
            return "world.json"
        }
    }
}

/// Coyo API service Protocol which CoyoAPICielnts  should be implemented
protocol NYTimesAPIService {
    /// Fetch All News
    func fetchNews(completion: @escaping (NetworkResult<NewsData>) -> Void)
}
    
final class NYTimesAPI {
    static let shared = NYTimesAPI()

    private let networkService: NetworkService
    private let baseURL = "https://api.nytimes.com/svc/topstories/v2/"
    private let apiKey = "8wB9oEMPx7ZrD55nSV6SIeJacz41S9SF"


    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
}

extension NYTimesAPI: NYTimesAPIService {
    func fetchNews(completion: @escaping (NetworkResult<NewsData>) -> Void) {
        executeRequestFor(.home, completion: completion)
    }
}

private extension NYTimesAPI {
    func executeRequestFor<T:Decodable>(
        _ endPoint: EndPoint,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(NetworkResult<T>) -> Void
    ) {
        if let urlRequest = prepareURlRequestFor(endPoint, parameters: parameters, headers: headers, method: method) {
            networkService.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
    }

    func prepareURlRequestFor(
        _ endPoint: EndPoint,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        
        let urlString = baseURL+endPoint.path+"?api-key="+apiKey
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)

        if let params = parameters {
            if method == .get || method == .delete {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                guard let newURL = urlComponents.url else {
                    return nil
                }
                request = URLRequest(url: newURL)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }

        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        return request
    }
}


