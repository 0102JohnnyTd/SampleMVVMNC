//
//  SignInViewModel.swift
//  SampleMVVMNC
//
//  Created by Johnny Toda on 2023/01/17.
//

import Foundation
import UIKit

final class SignInViewMdodel {
    // 監視元のViewのKeyとなるNotificationNameの定義
    let changeText = Notification.Name("changeText")
    let changeColor = Notification.Name("changeColor")

    private var notificationCenter: NotificationCenter
    private let signInModel: SignInModelDelegate

    // イニシャライザ
    init(notificationCenter: NotificationCenter, signInModel: SignInModelDelegate = SignInModel()) {
        self.notificationCenter = notificationCenter
        self.signInModel  = signInModel
    }

    // Controller側で呼び出す処理
    func textChanged(idText: String?, passwordText: String?) {
        let result = signInModel.validate(idText: idText, passwordText: passwordText)
        // 結果をController側に通知
        switch result {
        case .success():
            notificationCenter.post(name: changeText, object: "OK!")
            notificationCenter.post(name: changeColor, object: UIColor.green)
        case .failure(let error as SignInModelError):
            notificationCenter.post(name: changeText, object: error.message)
            notificationCenter.post(name: changeColor, object: UIColor.red)
        case .failure(_):
            fatalError("Unexpected Pattern")
        }
    }
}

// errrorに応じてControllerへ通知するメッセージを出し分ける
extension SignInModelError {
    var message: String {
        switch self {
        case .invalidId: return "IDが入力されていません"
        case .invalidPassword: return "Passwordが入力されていません"
        case .invalidIdAndPassword: return "IDとPasswordが入力されていません"
        }
    }
}
