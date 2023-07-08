//
//  CustomButton.swift
//  ThreeButtons
//
//  Created by Николай Игнатов on 04.07.2023.
//

import UIKit


final class CustomButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setImage(.init(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(.init(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        imageView?.tintColor = .white
        
        layer.cornerRadius = 8
        layer.cornerCurve = .continuous
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = self.isHighlighted ? .init(scaleX: 0.94, y: 0.94) : .identity
            }
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        if tintAdjustmentMode == .dimmed {
            self.imageView?.tintColor = .systemGray3
            self.setTitleColor(.systemGray3, for: .normal)
            self.backgroundColor = .systemGray2
        } else {
            self.imageView?.tintColor = .white
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .systemBlue
        }
    }
    
    func setInsets() {
        sizeToFit()
        let imageWidth = imageView?.frame.width ?? .zero
        let titleWidth = titleLabel?.frame.width ?? .zero
        let titleImageSpace: CGFloat = 8

        contentEdgeInsets = .init(top: 10, left: 14, bottom: 10, right: 14 + titleImageSpace)
        
        self.titleEdgeInsets = .init(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
        
        self.imageEdgeInsets = .init(top: 0, left: titleWidth + titleImageSpace, bottom: 0, right: -titleWidth - titleImageSpace)
    }
}
