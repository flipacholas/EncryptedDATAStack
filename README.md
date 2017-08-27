# EncryptedDATAStack
[![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]()
[![](http://img.shields.io/badge/Swift-3-red.svg)]()
[![CI Status](http://img.shields.io/travis/flipacholas/EncryptedDATAStack.svg?style=flat)](https://travis-ci.org/flipacholas/EncryptedDATAStack)
[![Version](https://img.shields.io/cocoapods/v/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![License](https://img.shields.io/cocoapods/l/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![Platform](https://img.shields.io/cocoapods/p/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)

Set up an encrypted Database with only 1 line of code!

**EncryptedDATAStack** is an fork of [DATAStack](https://github.com/SyncDB/DATAStack)  with added support of [Encrypted Core Data](https://github.com/project-imas/encrypted-core-data) (Core Data + SQLCipher) and extra legacy support for iOS 8.
All in all, this allows you to set up a database (encrypted and/or unencrypted) with only one line of code!

Version tags are set to match the version of DATAStack used.


## Table of Contents

* [Running the demos](#running-the-demo)
* [Initialization](#initialization)
* [Installation](#installation)
* [Main Thread NSManagedObjectContext](#main-thread-nsmanagedobjectcontext)
* [Background Thread NSManagedObjectContext](#background-thread-nsmanagedobjectcontext)
* [Clean up](#clean-up)
* [Testing](#testing)
* [Migrations](#migrations)
* [Improvements](#improvements)
* [Author](#author)
* [License](#license)

## Running the demo
Before being able to run the demo you have to install the demo dependencies using [CocoaPods](https://cocoapods.org/).

- Install CocoaPods
- Type `pod install`
- Run Example workspace

## Initialization

You can easily initialize a new instance of **EncryptedDATAStack** with just your Core Data Model name (xcdatamodel).

**Swift**
``` swift
let encryptedDataStack = EncryptedDATAStack(passphraseKey:"YOUR_PASSWORD", modelName:"MyAppModel")
```

**Objective-C**
``` objc
EncryptedDATAStack *encryptedDataStack = [[EncryptedDATAStack alloc] initWithPassphraseKey:@"YOUR_PASSWORD" modelName:@"MyAppModel"];
```

There are plenty of other ways to intialize an EncryptedDATAStack:

- Using a custom store type.

``` swift
//For Memory Storage
let encryptedDataStack = EncryptedDATAStack(modelName:"MyAppModel", storeType: .InMemory)
```

``` swift
//For Regular SQLite
let encryptedDataStack = EncryptedDATAStack(modelName:"MyAppModel", storeType: .sqLiteNoEncryption)
```

- Using another bundle and a store type, let's say your test bundle and .InMemory store type, perfect for running unit tests.

``` swift
let encryptedDataStack = EncryptedDATAStack(modelName: "Model", bundle: NSBundle(forClass: Tests.self), storeType: .InMemory)
```

- Using a different name for your .sqlite file than your model name, like `CustomStoreName.sqlite`.

``` swift
let encryptedDataStack = EncryptedDATAStack(passphraseKey:"YOUR_PASSWORD", modelName: "Model", bundle: NSBundle.mainBundle(), storeType: .sqLite, storeName: "CustomStoreName")
```

- Providing a diferent container url, by default we'll use the documents folder, most apps do this, but if you want to share your sqlite file between your main app and your app extension you'll want this.

``` swift
let encryptedDataStack = EncryptedDATAStack(passphraseKey:"YOUR_PASSWORD", modelName: "Model", bundle: NSBundle.mainBundle(), storeType: .sqLite, storeName: "CustomStoreName", containerURL: sharedURL)
```

## Main Thread NSManagedObjectContext

Getting access to the NSManagedObjectContext attached to the main thread is as simple as using the `mainContext` property.

```swift
self.encryptedDataStack.mainContext
```

or

```swift
self.encryptedDataStack.viewContext
```

## Background Thread NSManagedObjectContext

You can easily create a new background NSManagedObjectContext for data processing. This block is completely asynchronous and will be run on a background thread.

To be compatible with NSPersistentContainer you can also use `performBackgroundTask` instead of `performInNewBackgroundContext`.

**Swift**
```swift
func createUser() {
self.encryptedDataStack.performInNewBackgroundContext { backgroundContext in
let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: backgroundContext)!
let object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: backgroundContext)
object.setValue("Background", forKey: "name")
object.setValue(NSDate(), forKey: "createdDate")
try! backgroundContext.save()
}
}
```

**Objective-C**
```objc
- (void)createUser {
[self.encryptedDataStack performInNewBackgroundContext:^(NSManagedObjectContext * _Nonnull backgroundContext) {
NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:backgroundContext];
NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:backgroundContext];
[object setValue:@"Background" forKey:@"name"];
[object setValue:[NSDate date] forKey:@"createdDate"];
[backgroundContext save:nil];
}];
}
```

When using Xcode's Objective-C autocompletion the `backgroundContext` parameter name doesn't get included. Make sure to add it.

## Clean up

Deleting the `.sqlite` file and resetting the state of your **EncryptedDATAStack** is as simple as just calling `drop`.

**Swift**
```swift
self.encryptedDataStack.drop()
```

**Objective-C**
```objc
[self.encryptedDataStack forceDrop];
```

## Testing

**EncryptedDATAStack** is optimized for unit testing and it runs synchronously in testing enviroments. Hopefully you'll have to use less XCTestExpectations now.

You can create a stack that uses in memory store like this if your Core Data model is located in your app bundle:

**Swift**
```swift
let encryptedDataStack = EncryptedDATAStack(modelName: "MyAppModel", bundle: NSBundle.mainBundle(), storeType: .InMemory)
```

**Objective-C**
```objc
EncryptedDATAStack *encryptedDataStack = [[EncryptedDATAStack alloc] initWithModelName:@"MyAppModel"
bundle:[NSBundle mainBundle]
storeType:EncryptedDATAStackStoreTypeInMemory];
```

If your Core Data model is located in your test bundle:

**Swift**
```swift
let encryptedDataStack = EncryptedDATAStack(modelName: "MyAppModel", bundle: NSBundle(forClass: Tests.self), storeType: .InMemory)
```

**Objective-C**
```objc
EncryptedDATAStack *encryptedDataStack = [[EncryptedDATAStack alloc] initWithModelName:@"MyAppModel"
bundle:[NSBundle bundleForClass:[self class]]
storeType:EncryptedDATAStackStoreTypeInMemory];
```

## Migrations

If `EncryptedDATAStack` has troubles creating your persistent coordinator because a migration wasn't properly handled or the passphrase was incorrect it will destroy your data and create a new sqlite file. The normal Core Data behaviour for this is making your app crash on start. This is not fun.


## Installation

**EncryptedDATAStack** is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
use_frameworks!

pod 'EncryptedDATAStack', :git => 'https://github.com/flipacholas/EncryptedDATAStack.git'
```

## Improvements

You can open issues, pull requests... I will be happy to help

## Author

Rodrigo Copetti, [@flipacholas](https://twitter.com/flipacholas)

Special thanks to:

Elvis Nuñez, [@3lvis](https://twitter.com/3lvis) and Project iMAS, [project-imas](https://github.com/project-imas)

## License

**EncryptedDATAStack** is available under the Affero GPL v3 Licence.

...Just kidding, MIT license for you. See the LICENSE file for more info.
