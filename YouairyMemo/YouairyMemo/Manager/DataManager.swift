//
//  DataManager.swift
//  YouairyMemo
//
//  Created by Youvin Fairy on 20/06/2020.
//  Copyright © 2020 Youvin. All rights reserved.
//

import Foundation
import CoreData

class DataManager
{
    // 싱글톤
    static let shared = DataManager()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var feedList = [Memo]()
    
    func addNewFeed(text:String?, imagePath:String?)
    {
        let newFeed = Memo(context: mainContext)
        newFeed.content = text
        newFeed.date = Date()
        newFeed.imagePath = imagePath
        feedList.insert(newFeed, at: 0)
        saveContext()
    }
    
    func deleteFeed (_ feed:Memo?)
    {
        if let feed = feed {
            mainContext.delete(feed)
            saveContext()
        }
    }
    
    func fetchFeed()
    {
        let request : NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            feedList = try mainContext.fetch(request)
            
        }
        catch{
            print(error)
        }
        
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "YouairyMemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
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
