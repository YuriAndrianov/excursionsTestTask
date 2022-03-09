//
//  FirstRatingViewController.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import UIKit
import TGPControls

protocol FirstRatingViewProtocol: AnyObject {
    
    func setImage(from: Data)
    
}

typealias FirstRatingView = FirstRatingViewProtocol & UIViewController

final class FirstRatingViewController: UIViewController, FirstRatingViewProtocol {
    
    var presenter: FirstRatingViewPresenter?
    
    private var generalRatingView = CustomRatingView()
    private var guideRatingView = CustomRatingView()
    private var presentationRatingView = CustomRatingView()
    private var stepsNavigationRatingView = CustomRatingView()
    private var doneButton = UIButton()
    private var dismissButton = UIButton()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultPhoto")
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        setupPhotoImageView()
        setupStackView()
        setupButtons()
        setConstraints()
    }
    
    private func setupPhotoImageView() {
        view.addSubview(photoImageView)
        presenter?.getImage()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            label.textAlignment = .left
            label.numberOfLines = 2
            label.text = "Офигенно, Вы дошли до конца!\nРасскажите, как Вам?"
            return label
        }()
        
        generalRatingView = StyleSheet.shared.createCustomRatingView(with: "Как Вам тур в целом?")
        guideRatingView = StyleSheet.shared.createCustomRatingView(with: "Понравился гид?")
        presentationRatingView = StyleSheet.shared.createCustomRatingView(with: "Как Вам подача информации?")
        stepsNavigationRatingView = StyleSheet.shared.createCustomRatingView(with: "Удобная навигация между шагами?")
        
        [label, generalRatingView, guideRatingView, presentationRatingView, stepsNavigationRatingView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupButtons() {
        doneButton = StyleSheet.shared.createPurpleButton(withTitle: "Далее")
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        
        dismissButton = StyleSheet.shared.createWhiteButton(withTitle: "Не хочу отвечать")
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        view.addSubview(dismissButton)
    }
    
    func setImage(from data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.photoImageView.image = UIImage(data: data)
        }
    }
    
    @objc private func doneButtonTapped() {
        presenter?.createReviewWith(generalRating: generalRatingView.rating,
                                    guideRating: guideRatingView.rating,
                                    presentationRating: presentationRatingView.rating,
                                    stepsNavigationRating: stepsNavigationRatingView.rating)
    }
    
    @objc private func dismissButtonTapped() {
        presenter?.dismissButtonTapped()
    }

}

// MARK: - Constraints
extension FirstRatingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -10),
            
            doneButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -10),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
    
}

