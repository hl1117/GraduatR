//
//  AppDelegate.swift
//  graduatR
//
//  Created by Simona Virga on 2/7/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate
{
   

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
    {
      
        if (error) != nil
        {
            print("An error occurred during google authentication")
            return
        }
     
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error) != nil
            {
                print("Google authentication failed")
            }
            else
            {
                let databaseRef = Database.database().reference();
                print("Google authentication success")
                
                databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: {(sap) in
                    let enumer = sap.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(Auth.auth().currentUser!.uid)) {
                            print("HEREEEEEE")
                            print(rest.key)
                            print(Auth.auth().currentUser!.uid)
                            databaseRef.child("Users").child(rest.key).child(Auth.auth().currentUser!.uid).observeSingleEvent(of: DataEventType.value, with: { (snap) in
                                
                                
                                AllVariables.uid = Auth.auth().currentUser!.uid
                                print("HEREEE?")
                                let value = snap.value as? NSDictionary
                                AllVariables.Username = value?["Username"] as? String ?? ""
                                AllVariables.Fname = (value?["Fname"] as? String)!
                                AllVariables.Lname = (value?["Lname"] as? String)!
                                AllVariables.bio = value?["bio"] as? String ?? ""
                                AllVariables.GPA = value?["GPA"] as? String ?? ""
                                AllVariables.profpic = value?["profile_pic"] as? String ?? ""
                                AllVariables.standing = value?["Class"] as? String ?? ""
                                
                                databaseRef.child("Users").child(rest.key).child(AllVariables.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                                    let counter = 0;
                                    let enumer = snapshotCourse.children
                                    while let rest = enumer.nextObject() as? DataSnapshot {
                                        AllVariables.courses.append(rest.value as! String)
                                    }
                                })
                                
                                let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                                let appDelegate = UIApplication.shared.delegate
                                appDelegate?.window??.rootViewController = protectedPage
                                
                            })
                        }
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil);
                    let viewController: RoleViewController = storyboard.instantiateViewController(withIdentifier: "RoleViewController") as! RoleViewController;
                    
                    // Then push that view controller onto the navigation stack
                    let rootViewController = self.window!.rootViewController as! UINavigationController;
                    rootViewController.pushViewController(viewController, animated: true);
                })
            }
            
        }

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
         let googleAuthentication = GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation: [:])
        
        let facebookAuthentication = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        
        
        return googleAuthentication || facebookAuthentication
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "graduatR")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

