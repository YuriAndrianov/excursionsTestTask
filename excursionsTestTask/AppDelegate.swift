//
//  AppDelegate.swift
//  excursionsTestTask
//
//  Created by Юрий Андрианов on 08.03.2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainVC = MainViewController()
        let presenter = MainViewPresenter(view: mainVC)
        mainVC.presenter = presenter
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }

}

