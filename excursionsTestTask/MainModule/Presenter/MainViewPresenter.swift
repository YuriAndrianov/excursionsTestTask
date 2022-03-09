//
//  MainViewPresenter.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import Foundation
import UIKit

class MainViewPresenter {
    
    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
    
    func rateButtonTapped() {
        let firstRatingVC = FirstRatingViewController()
        let service = Service()
        let presenter = FirstRatingViewPresenter(view: firstRatingVC, service: service)
        firstRatingVC.presenter = presenter
        view?.present(firstRatingVC, animated: true, completion: nil)
    }
    
}

