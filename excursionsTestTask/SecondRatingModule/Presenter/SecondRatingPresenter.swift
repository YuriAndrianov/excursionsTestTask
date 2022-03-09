//
//  SecondRatingPresenter.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import Foundation

class SecondRatingViewPresenter {
    weak var view: SecondRatingView?
    var service: NetworkServiceProtocol?
    var review: Review?

    init(view: SecondRatingView, service: NetworkServiceProtocol, review: Review) {
        self.view = view
        self.service = service
        self.review = review
    }

    func getImage() {
        service?.getImageFromUrl(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.view?.setImage(from: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func addDetailedInformationToReview(text1: String, text2: String) {
        guard var review = review else { return }
        review.impressionDetail = text1
        review.improvementSuggestion = text2
        
        postReview(review)
    }
    
    func dismissButtonTapped() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func postReview(_ review: Review) {
        service?.postReview(review)
    }
    
}
