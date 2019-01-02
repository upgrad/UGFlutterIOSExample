//
//  AppDelegate.swift
//  UGFlutterIOSExample
//
//  Created by Prateek Grover on 02/01/19.
//  Copyright © 2019 UpGrad Education Private Limited. All rights reserved.
//

import UIKit
import UserNotifications
import Flutter
import FlutterPluginRegistrant
import UGFlutter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FlutterAppLifeCycleProvider, FlutterPluginRegistry, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    var flutterAppLifeCycleDelegate: FlutterPluginAppLifeCycleDelegate!
    
    //MARK: Methods added for Flutter integration
    override init() {
        self.flutterAppLifeCycleDelegate = FlutterPluginAppLifeCycleDelegate()
    }
    
    func rootFlutterViewController() -> FlutterViewController? {
        guard let viewController: UIViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        guard viewController.isKind(of: FlutterViewController.self), let flutterRootViewController = viewController as? FlutterViewController else {
            return nil
        }
        return flutterRootViewController
    }
    
    //MARK: Normal delegate methods
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UGFlutter.configure()
        return self.flutterAppLifeCycleDelegate.application(application, willFinishLaunchingWithOptions: launchOptions ?? [:])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if self.rootFlutterViewController() != nil {
            self.rootFlutterViewController()?.handleStatusBarTouches(event)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.flutterAppLifeCycleDelegate.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.flutterAppLifeCycleDelegate.applicationWillEnterForeground(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        self.flutterAppLifeCycleDelegate.applicationWillResignActive(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.flutterAppLifeCycleDelegate.applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.flutterAppLifeCycleDelegate.applicationWillTerminate(application)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        self.flutterAppLifeCycleDelegate.application(application, didRegister: notificationSettings)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.flutterAppLifeCycleDelegate.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.flutterAppLifeCycleDelegate.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        self.flutterAppLifeCycleDelegate.application(application, didReceive: notification)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.flutterAppLifeCycleDelegate.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.flutterAppLifeCycleDelegate.application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return self.flutterAppLifeCycleDelegate.application(application, handleOpen: url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.flutterAppLifeCycleDelegate.application(application, open: url, sourceApplication: sourceApplication!, annotation: annotation)
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        return self.flutterAppLifeCycleDelegate.application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        self.flutterAppLifeCycleDelegate.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.flutterAppLifeCycleDelegate.application(application, performFetchWithCompletionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return self.flutterAppLifeCycleDelegate.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    func addApplicationLifeCycleDelegate(_ delegate: FlutterPlugin) {
        self.flutterAppLifeCycleDelegate.add(delegate)
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GeneratedPluginRegistrant.register(with: self)
        return self.flutterAppLifeCycleDelegate.application(application, didFinishLaunchingWithOptions: launchOptions ?? [:])
    }
    
    //MARK: FlutterPluginRegistry. All delegating to root view controller
    
    //This warning cannot be solved as of now as the protocol is written with non optional but implementation requires optional
    func registrar(forPlugin pluginKey: String) -> FlutterPluginRegistrar! {
        guard let rootViewController = self.window?.rootViewController, let flutterRootViewController = rootViewController as? FlutterViewController else {
            return nil
        }
        return flutterRootViewController.pluginRegistry()!.registrar(forPlugin: pluginKey)
    }
    
    func hasPlugin(_ pluginKey: String) -> Bool {
        guard let rootViewController = self.window?.rootViewController, let flutterRootViewController = rootViewController as? FlutterViewController else {
            return false
        }
        return flutterRootViewController.pluginRegistry()!.hasPlugin(pluginKey)
    }
    
    //This warning cannot be solved as of now as the protocol is written with non optional but implementation requires optional
    func valuePublished(byPlugin pluginKey: String) -> NSObject! {
        guard let rootViewController = self.window?.rootViewController, let flutterRootViewController = rootViewController as? FlutterViewController else {
            return nil
        }
        return flutterRootViewController.pluginRegistry()!.valuePublished(byPlugin: pluginKey)
    }
}


