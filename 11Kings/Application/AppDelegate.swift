//
//  AppDelegate.swift
//  LoginScreen
//
//  Created by Duy Bui - iOS App Templates on 10/29/19.
//  Copyright © 2019 Duy Bui - iOS App Templates. All rights reserved.
//

import UIKit
import FacebookCore
import GoogleSignIn
import Firebase
import UserNotifications
import FirebaseMessaging
import FirebaseInstanceID
import IQKeyboardManagerSwift
import ChatSDK
import ChatProvidersSDK

var APP_DEL = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 let gcmMessageIDKey = "gcm.message_id"
  var window: UIWindow?
  var contestFormat = ""
    var panName:String?
    var panNumber:String?
    var panDob:String?
    var amountBank:String?
       var accountName:String?
       var acocuntNumber :String?
       var ifscAccount :String?
    var appStoreUrl:String?
     var batMansArray = [PlayerListResponses]()
       var bowlMansArray = [PlayerListResponses]()
       var allMansArray = [PlayerListResponses]()
       var wkMansArray = [PlayerListResponses]()
       var choosedTeamArray = [PlayerListResponses]()
       var kabaddiAllrounder = [PlayerListResponses]()
       var KabaddiDefender = [PlayerListResponses]()
       var KabaddiRaiders = [PlayerListResponses]()
     var KabaddiCenterArray = [PlayerListResponses]()
    var KabaddiPgArray = [PlayerListResponses]()
       var kabbaddiChoosedTeamArray = [PlayerListResponses]()
       var kabaddichoosedAllrounderArray = [PlayerListResponses]()
       var kabaddichoosedDefenderArray = [PlayerListResponses]()
       var kabaddichossedRaiderArray = [PlayerListResponses]()
       var KabaddiChoosedPGArray = [PlayerListResponses]()
     var kabaddiChoosedCenterArray = [PlayerListResponses]()
    
       var FootballGoalKeeperArray = [PlayerListResponses]()
       var FootballDefenderArray = [PlayerListResponses]()
       var FootballMidFielderArray = [PlayerListResponses]()
       var FootballFowordArray = [PlayerListResponses]()
       var footballChoosedTeamArray = [PlayerListResponses]()
       var FootballchoosedGoalKeeperArray = [PlayerListResponses]()
             var FootballchoosedDefenderArray = [PlayerListResponses]()
             var FootballchoosedMidFielderArray = [PlayerListResponses]()
             var FootballchoosedFowordArray = [PlayerListResponses]()
       var selectedPowerPlayOverinning1i1p = [Int]()
       var selectedPowerPlayOverinning1i2p = [Int]()
       var selectedPowerPlayOverinning1i3p = [Int]()
       var selectedPowerPlayOverinning2i1p = [Int]()
       var selectedPowerPlayOverinning2i2p = [Int]()
       var selectedPowerPlayOverinning2i3p = [Int]()
       //var contestFormat = ""
       var i1p1os = 0
       var i1p1oe = 0
       var i1p2os = 0
       var i1p2oe = 0
       var i1p3os = 0
       var i1p3oe = 0
       var i2p1os = 0
       var i2p1oe = 0
       var i2p2os = 0
       var i2p2oe = 0
       var i2p3os = 0
       var i2p3oe = 0
       var maxBat = 6
       var maxWk = 2
       var maxAll = 6
       var maxBall = 6
       var minBat = 2
    var minBowl = 2
    var minWk = 1
    var minAll = 2
    var extraPlayer = 4
    var FootballExtraPlayer = 5
    var minGoalKeeper = 1
    var minDef = 2
    var minMid = 2
    var minForword = 1
    var maxGK = 1
    var maxDef = 6
    var maxMid = 6
    var maxForwrd = 1
    var minpg = 1
    var maxpg = 4
    var minCenter = 1
    var maxCenter = 4
    var maxAr = 4
    var maxKabaddiDef = 4
    var maxRaid = 4
    var minRaid = 1
    var minKabaddiDef = 1
    var minAR = 1
    var KabaddiExtraPlayer = 3
        var editBatMansArray = [PlayerListResponses]()
       var editBowlMansArray = [PlayerListResponses]()
       var editAllMansArray = [PlayerListResponses]()
       var editWkMansArray = [PlayerListResponses]()
       var editChoosedTeamArray = [PlayerListResponses]()
    var choosedBatMansArray = [PlayerListResponses]()
    var choosedBowlMansArray = [PlayerListResponses]()
    var chossedAllMansArray = [PlayerListResponses]()
    var choosedWkMansArray = [PlayerListResponses]()
 //   var editChoosedTeamArray = [PlayerListResponses]()
var zendeskAppid = "214284884766842881"
var zendeskAccountKey = "1qcTDkBnZSIT435qbr943J4VDVx5zTcU"
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
   
//    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    IQKeyboardManager.shared.enable = true
//  C  Chat.initialize(accountKey: "7Z90eytnRtwc9b51llLo1yY6wMuGU6rj")

    Chat.initialize(accountKey: zendeskAccountKey,appId: zendeskAppid)
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    openInitialViewController()
    FirebaseApp.configure()
     setUpFireBaseNotification(application: application)
    return true
  }
    func openInitialViewController() {
        if UserDefaults.standard.bool(forKey: kLoggedIn) {
            let tabBarVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
            self.window!.backgroundColor = UIColor.white
            self.window!.rootViewController = tabBarVC
            self.window!.makeKeyAndVisible()
        } else {
            let signInVC = UIStoryboard.init(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: signInVC)
            navigationController.setNavigationBarHidden(true, animated: false)
            self.window!.backgroundColor = UIColor.white
            self.window!.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
        }

    }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return ApplicationDelegate.shared.application(app, open: url, options: options)
  }
}

extension AppDelegate {

    func setUpFireBaseNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //let token = String.init(data: deviceToken, encoding: .utf8)
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        print("APNs token retrieved: \(token)")
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("1234")
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if  let bedgeCount = response.notification.request.content.badge {
            UIApplication.shared.applicationIconBadgeNumber = Int(truncating: bedgeCount)
        } else {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}
