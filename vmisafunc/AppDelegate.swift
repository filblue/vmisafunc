//
//  AppDelegate.swift
//  vmisafunc
//
//  Created by Denis Fileev on 9/6/15.
//  Copyright © 2015 Denis Fileev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let vc = window?.rootViewController as! ViewController
        
        vc.viewModel = viewModelWith(Model(
            imageLoader: downloadXCKDImage
        ))
        
        return true
    }
}

