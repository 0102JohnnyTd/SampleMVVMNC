//
//  SignInViewController.swift
//  SampleMVVMNC
//
//  Created by Johnny Toda on 2023/01/17.
//

import UIKit

final class SignInViewController: UIViewController {
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!
    // インスタンスを生成
    private let notificationCenter = NotificationCenter()
    private lazy var signInViewModel = SignInViewMdodel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNotificationCenter()
    }


    // ViewをViewModelが監視している状態に設定
    private func setUpNotificationCenter() {
        notificationCenter.addObserver(
            self,
            selector: #selector(updateLabelText),
            name: signInViewModel.changeText,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(updateLabelColor),
            name: signInViewModel.changeColor,
            object: nil
        )
    }
}


extension SignInViewController {
    @objc func updateLabelText(notification: Notification) {
        guard let validateText = notification.object as? String else { return }
        validationLabel.text = validateText
    }

    @objc func updateLabelColor(notification: Notification) {
        guard let newTextColor = notification.object as? UIColor else { return }
        validationLabel.textColor = newTextColor
    }
}
