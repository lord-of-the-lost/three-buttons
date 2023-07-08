//
//  FirstViewController.swift
//  ThreeButtons
//
//  Created by Николай Игнатов on 04.07.2023.
//

import UIKit

final class FirstViewController: UIViewController {
    
    private lazy var firstButton = CustomButton(title: "First Button")
    private lazy var secondButton = CustomButton(title: "Second Medium Button")
    private lazy var thirdButton = CustomButton(title: "Third")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        firstButton.setInsets()
        secondButton.setInsets()
        thirdButton.setInsets()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        thirdButton.addTarget(self, action: #selector(openModalVC), for: .touchUpInside)
    }
    
    @objc private func openModalVC() {
        self.present(SecondViewController(), animated: true)
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
}
