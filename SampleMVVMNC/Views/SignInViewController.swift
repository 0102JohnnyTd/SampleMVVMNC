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
        setUpTextFiled()
    }

    // TextFieldの値が変更される度にViewからViewModelへ通知がかかる処理を定義
    private func setUpTextFiled() {
        idTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        passwordTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
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
    // ViewModelからpostによって通知が届いた際に実行される
    @objc func updateLabelText(notification: Notification) {
        guard let validateText = notification.object as? String else { return }
        validationLabel.text = validateText
    }
    // ViewModelからpostによって通知が届いた際に実行される
    @objc func updateLabelColor(notification: Notification) {
        guard let newTextColor = notification.object as? UIColor else { return }
        validationLabel.textColor = newTextColor
    }

    // textFieldの値が変更される度に実行される
    @objc func textDidChange() {
        signInViewModel.textChanged(idText: idTextField.text, passwordText: passwordTextField.text)
    }
}
