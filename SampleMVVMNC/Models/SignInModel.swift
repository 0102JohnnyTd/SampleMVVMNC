//
//  SignInModel.swift
//  SampleMVVMNC
//
//  Created by Johnny Toda on 2023/01/17.
//

import Foundation

// エラーを列挙
enum SignInModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol SignInModelDelegate {
    func validate(idText: String?, passwordText: String?) -> Result<Void, Error>
}

final class SignInModel: SignInModelDelegate {
    func validate(idText: String?, passwordText: String?) -> Result<Void, Error> {
        switch (idText, passwordText) {
        // 値が存在しなかった場合はエラーを返すようにする
        case (.none, .some): return .failure(SignInModelError.invalidId)
        case (.some, .none): return .failure(SignInModelError.invalidId)
        case (.none, .none): return .failure(SignInModelError.invalidIdAndPassword)
        // 値は存在するが、空文字だった場合もエラーを返す
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, false): return .failure(SignInModelError.invalidId)
            case (false, true): return .failure(SignInModelError.invalidPassword)
            case (true, true): return .failure(SignInModelError.invalidIdAndPassword)
            case (false, false): return .success(())
            }
        }
    }
}
