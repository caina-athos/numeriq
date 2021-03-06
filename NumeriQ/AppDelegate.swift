//
//  AppDelegate.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension SwinjectStoryboard {

    @objc class func setup() {
        // Models
        defaultContainer.register(MoyaProvider<NewsApi>.self) { _ in
            MoyaProvider<NewsApi>()
        }
        defaultContainer.register(ArticlesServiceType.self) { r in
            ArticlesService(provider: r.resolve(MoyaProvider<NewsApi>.self)!)
        }

        // View models
        defaultContainer.register(HomeViewModelType.self) { r in
            HomeViewModel(articlesService: r.resolve(ArticlesServiceType.self)!)
        }

        // Views
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { (r, c) in
            c.viewModel = r.resolve(HomeViewModelType.self)!
        }
    }

}
