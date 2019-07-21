//
//  LoginViewController.swift
//  LineChat
//
//  Created by 大江祥太郎 on 2019/07/21.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit
import Firebase     //追加
import GoogleSignIn//追加

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    //２つのデリゲートのプロトコルを追加
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* ここから追加 */
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        /* ここまで追加 */
    }
    
    /*** ここから追加！ ***/
    
    //チャット画面への遷移メソッド
    func transitionToChatRoom() {
        performSegue(withIdentifier: "toChat", sender: self)//"toChatRoom"というIDで識別
    }
    
    //Googleサインインに関するデリゲートメソッド
    //signIn:didSignInForUser:withError: メソッドで、Google ID トークンと Google アクセス トークンを
    //GIDAuthentication オブジェクトから取得して、Firebase 認証情報と交換します。
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        
        //最後に、認証情報を使用して Firebase での認証を行います
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("\nLogin succeeded\n")
            self.transitionToChatRoom()
        }
    }
    
    /*** ここまで追加！ ***/
    //サインアウトボタンを押したときの処理
    @IBAction func tappedSignOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("SignOut is succeeded")
            reloadInputViews()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

