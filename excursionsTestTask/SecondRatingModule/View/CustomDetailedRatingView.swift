//
//  CustomDetailedRatingView.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 09.03.2022.
//

import UIKit

final class CustomDetailedRatingView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 16)

        if #available(iOS 13.0, *) {
            textView.textColor = .label
        } else {
            textView.textColor = .black
        }
        
        textView.textContainer.maximumNumberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var detailedRatingText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        addSubview(contentView)
        addSubview(label)
        addSubview(textView)
        
        let placeholderText = "Напишите здесь, чем Вам запомнился тур, посоветуете ли его друзьям, и удалось ли повеселиться"
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc private func textViewTextChanged(_ sender: UITextView) {
        self.detailedRatingText = sender.text
    }
    
}
