//
//  SecondRatingViewController.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import UIKit

protocol SecondRatingViewProtocol: AnyObject {
    
    func setImage(from: Data)
    
}

typealias SecondRatingView = SecondRatingViewProtocol & UIViewController

final class SecondRatingViewController: SecondRatingView {
    
    var presenter: SecondRatingViewPresenter?
    
    private var impressionDetailView = CustomDetailedRatingView()
    private var improvementSuggestionView = CustomDetailedRatingView()
    private var saveReviewButton = UIButton()
    private var dismissButton = UIButton()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultPhoto")
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var activeView: UIView?
    
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
        createToolBar()
        setConstraints()
    }

    private func setupPhotoImageView() {
        view.addSubview(photoImageView)
        presenter?.getImage()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
  
        impressionDetailView = StyleSheet.shared.createCustomDetailedRatingView(with: "Что особенно понравилось в этом туре?")
        improvementSuggestionView = StyleSheet.shared.createCustomDetailedRatingView(with: "Как мы могли бы улучшить подачу информации?")
        
        impressionDetailView.textView.delegate = self
        improvementSuggestionView.textView.delegate = self
        
        [impressionDetailView, improvementSuggestionView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
 
    private func setupButtons() {
        saveReviewButton = StyleSheet.shared.createPurpleButton(withTitle: "Сохранить отзыв")
        saveReviewButton.addTarget(self, action: #selector(saveReviewButtonTapped), for: .touchUpInside)
        view.addSubview(saveReviewButton)
        
        dismissButton = StyleSheet.shared.createWhiteButton(withTitle: "Пропустить")
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        view.addSubview(dismissButton)
    }
    
    private func createToolBar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                        target: nil,
                                        action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItem.Style.plain,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        toolbar.items = [cancelButton, flexSpace, doneButton]
        
        impressionDetailView.textView.inputAccessoryView = toolbar
        improvementSuggestionView.textView.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        if let activeView = activeView {
            if activeView.isFirstResponder {
                (activeView as? UITextView)?.text = nil
            }
        }
        view.endEditing(true)
    }
    
    @objc private func saveReviewButtonTapped() {
        
    }
    
    @objc private func dismissButtonTapped() {
        presenter?.dismissButtonTapped()
    }
    
    func setImage(from data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.photoImageView.image = UIImage(data: data)
        }
    }

}

extension SecondRatingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: saveReviewButton.topAnchor, constant: -10),
            
            saveReviewButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            saveReviewButton.heightAnchor.constraint(equalToConstant: 40),
            saveReviewButton.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -10),
            saveReviewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

// MARK: - Delegates
extension SecondRatingViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeView = nil
        if textView.text.isEmpty {
            let placeholderText = "Напишите здесь, чем Вам запомнился тур, посоветуете ли его друзьям, и удалось ли повеселиться"
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeView = textView
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            
            if #available(iOS 13.0, *) {
                textView.textColor = .label
            } else {
                textView.textColor = .black
            }
        }
    }
    
}
