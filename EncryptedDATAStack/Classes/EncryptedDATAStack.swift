//
//  EncryptedDATAStack.swift
//
//
//  Created by Rodrigo Copetti on 21/10/2016.
//
//

import EncryptedCoreData

public class EncryptedDATAStack: DATAStack {
    private var hashKey: String

    override internal var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        get {
            if _persistentStoreCoordinator == nil {
                let filePath = (storeName ?? modelName) + ".sqlite"
                let storeURL = containerURL.URLByAppendingPathComponent(filePath)
                let model = NSManagedObjectModel(bundle: self.modelBundle, name: self.modelName)
                let options = [EncryptedStorePassphraseKey: self.hashKey, EncryptedStoreDatabaseLocation: storeURL!]
                let persistentStoreCoordinator = EncryptedStore.makeStoreWithOptions(options, managedObjectModel: model)
                
                _persistentStoreCoordinator = persistentStoreCoordinator
            }

            return _persistentStoreCoordinator!
        }
    }

    public init(hashKey:String) {
        self.hashKey = hashKey
        super.init()
    }

   
    public init(modelName: String, hashKey: String) {
        self.hashKey = hashKey
        
        super.init(modelName: modelName)
        
    }

   
  
    public init(modelName: String, hashKey: String, bundle: NSBundle) {
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .SQLite)
    }

    
    public init(modelName: String, hashKey: String, bundle: NSBundle, storeName: String) {
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .SQLite, storeName: storeName)
    }

    
    public init(modelName: String, hashKey: String, bundle: NSBundle, storeName: String, containerURL: NSURL) {
        
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .SQLite, storeName: storeName, containerURL: containerURL)
    }

}
