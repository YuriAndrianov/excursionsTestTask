//
//  StyleSheet.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import UIKit
import TGPControls

class StyleSheet {
    
    static let shared = StyleSheet()
    
    private init() {}

    let emojies: [String] = ["😡", "☹️", "😐", "🙂", "😃"]
    let imageURLString = "https://app.wegotrip.com/media/users/1/path32.png"
    
    //"https://webhook.site/c8f2041c-c57e-433f-853f-1ef739702903" - указанная Вами в задании страница не найдена, поэтому для теста заведен другой адрес:
    let postReviewURLString = "https://jsonplaceholder.typicode.com/posts"
    
    func createCustomRatingView(with question: String) -> CustomRatingView {
        let view = CustomRatingView()
        view.questionLabel.text = question
        return view
    }
    
    func createCustomDetailedRatingView(withTitle description: String) -> CustomDetailedRatingView {
        let view = CustomDetailedRatingView()
        view.label.text = description
        return view
    }
    
    func createPurpleButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "buttonColor")
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createWhiteButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
