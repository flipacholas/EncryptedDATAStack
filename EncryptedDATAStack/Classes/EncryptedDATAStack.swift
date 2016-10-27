//
//  EncryptedDATAStack.swift
//
//
//  Created by Rodrigo Copetti on 21/10/2016.
//
//

import EncryptedCoreData

public class EncryptedDATAStack: DATAStack {
    fileprivate var hashKey: String
    

    override internal var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        get {
            if _persistentStoreCoordinator == nil {
                let filePath = (storeName ?? modelName) + ".sqlite"
                let storeURL = containerURL.appendingPathComponent(filePath)
                let model = NSManagedObjectModel(bundle: self.modelBundle, name: self.modelName)
                let options = [EncryptedStorePassphraseKey: self.hashKey, EncryptedStoreDatabaseLocation: storeURL] as [String : Any]
                let persistentStoreCoordinator = EncryptedStore.make(options: options, managedObjectModel: model)
                
                _persistentStoreCoordinator = persistentStoreCoordinator
            }

            return _persistentStoreCoordinator!
        }
    }

    public init(modelName: String, hashKey: String) {
        self.hashKey = hashKey
        
        super.init(modelName: modelName)
        
    }

   
  
    public init(modelName: String, hashKey: String, bundle: Bundle) {
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .sqLite)
    }

    
    public init(modelName: String, hashKey: String, bundle: Bundle, storeName: String) {
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .sqLite, storeName: storeName)
    }

    
    public init(modelName: String, hashKey: String, bundle: Bundle, storeName: String, containerURL: URL) {
        
        self.hashKey = hashKey

        super.init(modelName: modelName, bundle: bundle, storeType: .sqLite, storeName: storeName, containerURL: containerURL)
    }

}
