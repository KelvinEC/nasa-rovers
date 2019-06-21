//
//  BBNetwork.swift
//  Rovers
//
//  Created by Kelvin Lima on 20/06/19.
//  Copyright © 2019 BeBlue. All rights reserved.
//

import Foundation

public enum BBServerURL
{
    case dev
    case prod
    case custom(String)

    var url: String
    {
        switch self {
        case .dev:
            return "https://api.nasa.gov/mars-photos/api/v1/"
        case .prod:
            return "https://api.nasa.gov/mars-photos/api/v1/"
        case .custom(let url):
            return url
        }
    }
}

enum HTTPRequestTypes: String
{
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case post = "POST"
}

class BBNetworking: NSObject
{
    @objc public static let shared: BBNetworking = BBNetworking()

    private var _currentEndpoint: BBServerURL

    private let _urlSession: URLSession

    private var _authorization: String?

    @objc public var endpointURL: String {
        return self._currentEndpoint.url
    }

    private override init()
    {
        _currentEndpoint = .prod
        _urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    func execute(request: URLRequest, handler: @escaping (Result<BBServerResult, BBNetworkError>) -> Void)
    {
        let task = _urlSession.dataTask(with: request) { data, response, error in

            let parsedResponse = self.parseURLRequestResponse(data: data, urlResponse: response, error: error)

            switch parsedResponse {
            case .failure(let error):
                switch error {
                case .connectionError:
                    LKConnectionTest.checkInternetConnection { response in
                        switch response {
                        case .success:
                            handler(.failure(.serverUnavailable))
                        case .failure:
                            handler(.failure(.noInternetConnection))
                        }
                    }
                default:
                    handler(.failure(error))
                }
            case .success(let response):
                handler(.success(response))
            }
        }

        task.resume()
    }

    public func set(endpoint: BBServerURL)
    {
        _currentEndpoint = endpoint
    }

    @objc public func set(authorization: String?)
    {
        _authorization = authorization
    }

    func createRequest(operation: String,
                       type: HTTPRequestTypes,
                       parameters: [String: Any]?) -> URLRequest?
    {
        var components = URLComponents(string: _currentEndpoint.url + operation)
        var bodyData: Data?
        var queryParameters: String?
        var completeParameters = [String: Any]()
        completeParameters["api_key"] = _authorization

        parameters?.forEach{ key, value in
            completeParameters[key] = value
        }

        switch type {
        case .put:
            bodyData = urlizeParameters(parameters: completeParameters).data(using: .ascii)
        case .delete:
            queryParameters = urlizeParameters(parameters: completeParameters)
        case .get:
            queryParameters = urlizeParameters(parameters: completeParameters)
        case .post:
            bodyData = urlizeParameters(parameters: completeParameters).data(using: .ascii)
        }

        components?.percentEncodedQuery = queryParameters

        if let url = components?.url {
            var urlRequest: URLRequest = URLRequest(url: url,
                                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                                    timeoutInterval: 20.0)
            urlRequest.httpMethod = type.rawValue.capitalized
            urlRequest.httpBody = bodyData
            return urlRequest
        }

        return nil
    }

    private func urlizeParameters(parameters: [String: Any]) -> String
    {
        let allowedCharacterSet = CharacterSet(charactersIn: "/+=\n").inverted

        let query: [String] = parameters.map { key, value in
            let key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var val: String = ""

            if let v = value as? String {
                if let r = v.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)?
                    .addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    val = r
                }
            } else if let v = value as? Data {
                if let r = v.base64EncodedString().addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    val = r
                }
            } else if let v = value as? Int {
                if let r = v.description.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)?
                    .addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    val = r
                }
            } else if let v = value as? UInt32 {
                if let r = v.description.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)?
                    .addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    val = r
                }
            }

            return "\(key)=\(val)"
        }

        return query.joined(separator: "&")
    }

    private func parseURLRequestResponse(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<BBServerResult, BBNetworkError>
    {
        guard error == nil, let httpUrlResponse = urlResponse as? HTTPURLResponse, let responseData = data else {
            return .failure(.connectionError)
        }

        let result = BBServerResult(data: responseData)

        if httpUrlResponse.statusCode > 299 {
            return .failure(.apiError(result.asDictionary()?.description ?? "Unknown Error"))
        }

        return .success(result)
    }
}

public class BBServerResult
{
    private let _data: Data

    public var data: Data {
        return _data
    }

    init(data: Data)
    {
        _data = data
    }

    public func asDictionary() -> [String: Any]?
    {
        do {
            return try JSONSerialization.jsonObject(with: _data) as? [String: Any]
        } catch _ {
            return nil
        }
    }

    public func asArrayOfDictionaries() -> [[String: Any]]?
    {
        do {
            return try JSONSerialization.jsonObject(with: _data) as? [[String: Any]]
        } catch _ {
            return nil
        }
    }

    public func asObject<T: Codable>() -> T?
    {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return try jsonDecoder.decode(T.self, from: _data)
        } catch let e {
            print(e)
            return nil
        }
    }
}
