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

protocol StorageProtocol {
    
    func saveReview(_ review: Review)
    
}

typealias ServiceProtocol = NetworkServiceProtocol & StorageProtocol

class Service: ServiceProtocol {
    
    func getImageFromUrl(completion: @escaping ((Result<Data, Error>) -> Void)) {
        let urlString = StyleSheet.shared.imageURLString
        guard let url = URL(string: urlString) else { return }

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
        
    }
    
    func saveReview(_ review: Review) {
//        UserDefaults.standard.set(review, forKey: "review")
    }
    
}

