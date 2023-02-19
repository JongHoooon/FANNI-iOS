//
//  AppDelegate.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/05.
//

import UIKit
import RxKakaoSDKCommon
import RxKakaoSDKAuth
import KakaoSDKAuth
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        if let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String {
            RxKakaoSDK.initSDK(appKey: kakaoAppKey)
        }

        return true
    }
    
    func application(
      _ app: UIApplication,
      open url: URL,
      options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
       
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.
      // If not handled by this app, return false.
      return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
