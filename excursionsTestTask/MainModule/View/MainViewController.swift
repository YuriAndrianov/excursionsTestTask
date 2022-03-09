//
//  MainViewController.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewPresenter?
    
    private var rateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        setupRateButton()
    }
    
    private func setupRateButton() {
        rateButton = StyleSheet.shared.createPurpleButton(withTitle: "Оценить")
        rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        view.addSubview(rateButton)
        
        NSLayoutConstraint.activate([
            rateButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            rateButton.heightAnchor.constraint(equalToConstant: 40),
            rateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func rateButtonTapped() {
        presenter?.rateButtonTapped()
    }

}

