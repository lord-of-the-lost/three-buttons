//
//  FirstViewController.swift
//  ThreeButtons
//
//  Created by Николай Игнатов on 04.07.2023.
//

import UIKit

final class FirstViewController: UIViewController {
    
    enum ButtonType: String {
        case first = "First Button"
        case second = "Second Medium Button"
        case third = "Third"
    }
    
    private lazy var firstButton = CustomButton(configuration: setupButton(type: .first))
    private lazy var secondButton = CustomButton(configuration: setupButton(type: .second))
    private lazy var thirdButton = CustomButton(configuration: setupButton(type: .third), primaryAction: UIAction(handler: { _ in
        self.present(SecondViewController(), animated: true)
    }))
    
    private var buttonAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupButtonAnimations()
    }
    
    private func setupButton(type: ButtonType) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = type.rawValue
        configuration.image = UIImage(systemName: "arrow.right.circle.fill")
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        return configuration
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 10),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 10),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupButtonAnimations() {
        firstButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        firstButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
        
        secondButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        secondButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
        
        thirdButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        thirdButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func buttonTouchDown(_ sender: UIButton) {
        if let buttonAnimator = buttonAnimator, buttonAnimator.isRunning {
            buttonAnimator.pauseAnimation()
        } else {
            let targetScale: CGFloat = 0.9
            buttonAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut, animations: {
                sender.transform = CGAffineTransform(scaleX: targetScale, y: targetScale)
            })
            buttonAnimator?.startAnimation()
        }
    }
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        if var buttonAnimator = buttonAnimator, buttonAnimator.isRunning {
            buttonAnimator.pauseAnimation()
            buttonAnimator.isReversed = true
            let fraction = buttonAnimator.fractionComplete
            
            buttonAnimator.stopAnimation(true)
            buttonAnimator.finishAnimation(at: .current)
            
            let targetScale: CGFloat = 1.0
            
            let newAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
                sender.transform = CGAffineTransform(scaleX: targetScale, y: targetScale)
            }
            newAnimator.fractionComplete = fraction
            newAnimator.startAnimation()
            buttonAnimator = newAnimator
        } else {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [], animations: {
                sender.transform = .identity
            })
        }
    }
}
