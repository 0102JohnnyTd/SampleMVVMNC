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

    // インスタンスを生成
    private let notificationCenter = NotificationCenter()
    private lazy var signInViewModel = SignInViewMdodel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}
