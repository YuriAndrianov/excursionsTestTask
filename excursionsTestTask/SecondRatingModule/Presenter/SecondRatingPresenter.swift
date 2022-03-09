//
//  SecondRatingPresenter.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import Foundation
import UIKit

class SecondRatingViewPresenter {
    weak var view: SecondRatingView?
    var service: ServiceProtocol?

    init(view: SecondRatingView, service: ServiceProtocol) {
        self.view = view
        self.service = service
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
    
    func createReviewWith(generalRating: Int, guideRating: Int, presentationRating: Int, stepsNavigationRating: Int) {
//        let id = "\(Int.random(in: 1...100))"
//        let review = Review(id: id,
//                            generalRating: generalRating,
//                            guideRating: guideRating,
//                            presentationRating: presentationRating,
//                            stepsNavigationRating: stepsNavigationRating,
//                            impressionDetail: "",
//                            improvementSuggestion: "")
//        saveReview(review)
    }
    
    func dismissButtonTapped() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func postReview(_ review: Review) {
        service?.postReview(review)
    }
    
}
