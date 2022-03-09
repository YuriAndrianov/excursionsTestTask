//
//  CustomRatingView.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import UIKit
import TGPControls

final class CustomRatingView: UIView {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var slider: TGPDiscreteSlider!
    @IBOutlet var contentView: UIView!
    
    var rating: Int = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        
        Bundle.main.loadNibNamed("CustomRatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged(_ sender: TGPDiscreteSlider) {
        let rate = Int(sender.value)
        self.rating = rate
        self.emojiLabel.text = StyleSheet.shared.emojies[rate - 1]
    }
    
}
