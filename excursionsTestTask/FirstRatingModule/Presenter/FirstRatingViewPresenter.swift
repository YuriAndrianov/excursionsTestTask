//
//  FirstRatingViewPresenter.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import Foundation
import UIKit

class FirstRatingViewPresenter {
    weak var view: FirstRatingView?
    var service: NetworkServiceProtocol?

    init(view: FirstRatingView, service: NetworkServiceProtocol) {
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
        let id = "\(Int.random(in: 1...100))"
        let review = Review(id: id,
                            generalRating: generalRating,
                            guideRating: guideRating,
                            presentationRating: presentationRating,
                            stepsNavigationRating: stepsNavigationRating,
                            impressionDetail: "",
                                  improvementSuggestion: "")
        showSecondRatingVC(with: review)
    }
    
    func dismissButtonTapped() {
        view?.dismiss(animated: true, completion: nil)
    }
 
    func showSecondRatingVC(with review: Review) {
        let secondRatingVC = SecondRatingViewController()
        let service = Service()
        let presenter = SecondRatingViewPresenter(view: secondRatingVC, service: service, review: review)
        secondRatingVC.presenter = presenter
        view?.present(secondRatingVC, animated: true, completion: nil)
    }
    
}
