//
//  NetworkService.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func getImageFromUrl(completion: @escaping ((Result<Data, Error>) -> Void))
    
    func postReview(_ review: Review)
    
}

class Service: NetworkServiceProtocol {
    
    func getImageFromUrl(completion: @escaping ((Result<Data, Error>) -> Void)) {
        let urlString = StyleSheet.shared.imageURLString
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                } else if let data = data {
                    completion(.success(data))
                } else { return }
            }
        }.resume()
    }
    
    func postReview(_ review: Review) {
        let urlString = StyleSheet.shared.postReviewURLString
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(review) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
}

