//
//  WebService.swift
//  ListStructure
//
//  Created by Hiren Faldu Solution on 18/05/22.
//

import Foundation

//// MARK: - Model
//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case delete = "DELETE"
//    case put = "PUT"
//}
//
//enum EncodingType {
//    case url
//    case parameter
//}
//
//enum BodyContentType {
//    case json
//    
//    var value: String {
//        switch self {
//        case .json: return "application/json"
//        }
//    }
//}
//
//typealias APICompletion = (_ statusCode: Int, _ json: Any) -> Void
//
//// MARK: - WebService
//struct WebService {
//    
//    static let shared = WebService()
//    
//    private let session: URLSession
//    private let sessionConfiguration: URLSessionConfiguration
//    private let defaultHeaders: [String: String] = [
//        "Accept": "application/json",
//        "Authorization": "Bearer \(accessToken)"
//    ]
//    
//    private init() {
//        sessionConfiguration = URLSessionConfiguration.default
//        sessionConfiguration.timeoutIntervalForRequest = 30
//        sessionConfiguration.timeoutIntervalForResource = 60
//        session = URLSession(configuration: sessionConfiguration)
//    }
//    
//    
//}
//
//// MARK: - API call method(s)
//extension WebService {
//    
//    func apiCall<T: Decodable>(method: HTTPMethod,
//                               url: URL,
//                               resultType: T.Type,
//                               completion: @escaping (T)-> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("*** error: \(error.localizedDescription) ***")
//            }
//            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                if let data = data {
//                    let decoder = JSONDecoder()
//                    do {
//                        let result = try decoder.decode(T.self, from: data)
//                        completion(result)
//                    } catch let error {
//                        print("*** Error while decoding: \(error.localizedDescription) ***")
//                    }
//                }
//            }
//        }.resume()
//    }
//    
//    func apiCall(method: HTTPMethod,
//                 url: URL,
//                 parameters: [String: Any]? = nil,
//                 headers: [String: String] = [:],
//                 compleiton: @escaping APICompletion) {
//        printAPIRequest(url: url,
//                        parameters: parameters)
//        
//        // Preparing URL request
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        if let parameters = parameters {
//            do {
//                try setParameters(request: &request,
//                                  encodingType: .parameter,
//                                  parameters: parameters)
//            } catch let error as NSError {
//                debugprint("*** Error in parameter serialization with url: \(url.absoluteString) and parameters: \(parameters) : \(error.localizedDescription) ***")
//            }
//        }
//        setHeaders(request: &request,
//                   headers: headers,
//                   contentType: .json)
//        
//        // Firing API
//        session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                debugprint("*** Error in API request: \(error.localizedDescription) ***")
//            }
//            if let response = response as? HTTPURLResponse,
//               response.statusCode == 200,
//               let data = data {
//                printAPIResponse(url: url,
//                                 parameters: parameters,
//                                 statusCode: response.statusCode,
//                                 data: data)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data)
//                    compleiton(response.statusCode, json)
//                } catch let error as NSError {
//                    debugprint("*** Error in JSON serialization: \(error.localizedDescription) ***")
//                }
//                compleiton(response.statusCode, data)
//            }
//        }.resume()
//    }
//}
//
//// MARK: - Header/Parameter method(s)
//private extension WebService {
//    
//    private func setParameters(request: inout URLRequest,
//                               encodingType: EncodingType,
//                               parameters: [String: Any]) throws {
//        do {
//            let httpBody =  try JSONSerialization.data(withJSONObject: parameters,
//                                                       options: [.prettyPrinted])
//            print(String(data: httpBody, encoding: .utf8)!)
//            request.httpBody = httpBody
//        } catch let error as NSError {
//            throw error
//        }
//    }
//    
//    private func setHeaders(request: inout URLRequest,
//                            headers: [String: String],
//                            contentType: BodyContentType) {
//        request.setValue(contentType.value, forHTTPHeaderField: "Accept")
//        request.setValue(contentType.value, forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        for (key, value) in defaultHeaders {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
//    }
//}
//
//// MARK: - Print method(s)
//private extension WebService {
//    
//    private func printAPIRequest(url: URL,
//                                 parameters: [String: Any]?) {
//        debugprint("\n((( API request \nurl: \(url.absoluteString), \nparameters: \(parameters ?? [:]) \n)))\n")
//    }
//    
//    private func printAPIResponse(url: URL,
//                                  parameters: [String: Any]?,
//                                  statusCode: Int,
//                                  data: Data) {
//        
//        if let json = try? JSONSerialization.jsonObject(with: data) {
//            if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
//                if let printJSON = String(data: data, encoding: .utf8) {
//                    debugprint("""
//                    <<< API response
//                    url: \(url.absoluteString),
//                    prameters: \(parameters ?? [:]),
//                    statusCode: \(statusCode),
//                    response body: \(String(describing: printJSON))
//                    >>>
//                    """
//                    )
//                }
//            }
//        }
//    }
//}
