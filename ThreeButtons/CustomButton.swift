//
//  CustomButton.swift
//  ThreeButtons
//
//  Created by Николай Игнатов on 04.07.2023.
//

import UIKit


final class CustomButton: UIButton {
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        if tintAdjustmentMode == .dimmed {
            backgroundColor = .gray
            layer.cornerRadius = 5
        } else {
            backgroundColor = .systemBlue
            layer.cornerRadius = 5
        }
    }
}
