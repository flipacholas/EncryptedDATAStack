# EncryptedDATAStack
[![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]()
[![](http://img.shields.io/badge/Swift-2.3-blue.svg)]()
[![CI Status](http://img.shields.io/travis/flipacholas/EncryptedDATAStack.svg?style=flat)](https://travis-ci.org/flipacholas/EncryptedDATAStack)
[![Version](https://img.shields.io/cocoapods/v/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![License](https://img.shields.io/cocoapods/l/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![Platform](https://img.shields.io/cocoapods/p/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)

Set up an encrypted Database with only 1 line of code!

**EncryptedDATAStack** is an extension of [DATAStack](https://github.com/SyncDB/DATAStack) made to work exclusively with [Encrypted Core Data](https://github.com/project-imas/encrypted-core-data) (Core Data + SQLCipher). It acts as a superset, which retains compatibility with the original DATAStack.


Support for Swift 3 will be added soon.

## Table of Contents

* [Running the demos](#running-the-demos)
* [Initialization](#initialization)
* [Main Thread NSManagedObjectContext](#main-thread-nsmanagedobjectcontext)
* [Background Thread NSManagedObjectContext](#background-thread-nsmanagedobjectcontext)
* [Clean up](#clean-up)
* [Testing](#testing)
* [Migrations](#migrations)
* [Installation](#installation)
* [Improvements](#be-awesome)
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
let encryptedStack = EncryptedDATAStack(modelName:"MyAppModel", key:"yourHashKey")
```

**Objective-C**
``` objc
DATAStack *dataStack = [[DATAStack alloc] initWithModelName:@"MyAppModel"];
```

- Using a custom bundle.

``` swift
let encryptedStack = EncryptedDATAStack(modelName:"MyAppModel", key:"yourHashKey", bundle: NSBundle(forClass: Tests.self))
```

- Using a different name for your .sqlite file than your model name, like `CustomStoreName.sqlite`.

``` swift
let encryptedStack = DATAStackmodelName:(modelName:"MyAppModel", key:"yourHashKey", bundle: NSBundle.mainBundle(), storeName: "CustomStoreName")
```

- Providing a diferent container url, by default we'll use the documents folder, most apps do this, but if you want to share your sqlite file between your main app and your app extension you'll want this.

``` swift
let encryptedStack = DATAStack(modelName:"MyAppModel", key:"yourHashKey", bundle: NSBundle.mainBundle(), storeName: "CustomStoreName", containerURL: sharedURL)
```

## Main Thread NSManagedObjectContext

Getting access to the NSManagedObjectContext attached to the main thread is as simple as using the `mainContext` property.

```swift
self.encryptedStack.mainContext
```

or 

```swift
self.encryptedStack.viewContext
```

## Background Thread NSManagedObjectContext

You can easily create a new background NSManagedObjectContext for data processing. This block is completely asynchronous and will be run on a background thread.

To be compatible with NSPersistentContainer you can also use `performBackgroundTask` instead of `performInNewBackgroundContext`.

**Swift**
```swift
func createUser() {
self.dataStack.performInNewBackgroundContext { backgroundContext in
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
[self.dataStack performInNewBackgroundContext:^(NSManagedObjectContext * _Nonnull backgroundContext) {
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

Deleting the `.sqlite` file and resetting the state of your **DATAStack** is as simple as just calling `drop`.

**Swift**
```swift
try self.dataStack.drop()
```

**Objective-C**
```objc
[self.dataStack forceDrop];
```

## Testing

**DATAStack** is optimized for unit testing and it runs synchronously in testing enviroments. **EncryptedDATAStack** maintains its compatibility with the only difference that the storage type used is SQLite.

You can create a stack that uses in memory store like this if your Core Data model is located in your app bundle:

**Swift**
```swift
let encryptedStack = EncryptedDATAStack(modelName: "MyAppModel", key:"yourHashKey", bundle: NSBundle.mainBundle())
```

**Objective-C**
```objc
DATAStack *dataStack = [[DATAStack alloc] initWithModelName:@"MyAppModel"
bundle:[NSBundle mainBundle]
storeType:DATAStackStoreTypeInMemory];
```

If your Core Data model is located in your test bundle:

**Swift**
```swift
let dataStack = DATAStack(modelName: "MyAppModel", key:"yourHashKey", bundle: NSBundle(forClass: Tests.self))
```

**Objective-C**
```objc
DATAStack *dataStack = [[DATAStack alloc] initWithModelName:@"MyAppModel"
bundle:[NSBundle bundleForClass:[self class]]
storeType:DATAStackStoreTypeInMemory];
```

## Migrations

Originally, if `DATAStack` has troubles creating your persistent coordinator because a migration wasn't properly handled it will destroy your data and create a new sqlite file. --This features has yet to be tested--

## Installation

Attention: A copy of DATAStack.swift is already included in this pod.

**EncryptedDATAStack** is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
use_frameworks!

pod 'EncryptedDATAStack'
```

**EncryptedDATAStack** is also available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github 'flipacholas/EncryptedDATAStack'
```

## Improvements

You can open issues, pull requests... I will be happy to help

## Author

Rodrigo Copetti, [@flipacholas](https://twitter.com/flipacholas)

Special thanks to:

Elvis Nuñez, [@3lvis](https://twitter.com/3lvis) and Project iMAS, [project-imas](https://github.com/project-imas)

## License

**EncryptedDATAStack** like **DATAStack**  is available under the MIT license. See the LICENSE file for more info.
