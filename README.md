# EncryptedDATAStack
[![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]()
[![](http://img.shields.io/badge/Swift-3-red.svg)]()
[![CI Status](http://img.shields.io/travis/flipacholas/EncryptedDATAStack.svg?style=flat)](https://travis-ci.org/flipacholas/EncryptedDATAStack)
[![Version](https://img.shields.io/cocoapods/v/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![License](https://img.shields.io/cocoapods/l/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)
[![Platform](https://img.shields.io/cocoapods/p/EncryptedDATAStack.svg?style=flat)](http://cocoapods.org/pods/EncryptedDATAStack)

Set up an encrypted Database with only 1 line of code!

**EncryptedDATAStack** is an extension of [DATAStack](https://github.com/SyncDB/DATAStack) made to work exclusively with [Encrypted Core Data](https://github.com/project-imas/encrypted-core-data) (Core Data + SQLCipher). It acts as a superset, which retains compatibility with the original DATAStack.


## Table of Contents

* [Running the demos](#running-the-demo)
* [Initialization](#initialization)
* [Installation](#installation)
* [Improvements](#Improvements)
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
DATAStack *dataStack = [[EncryptedDATAStack alloc] initWithModelName:@"MyAppModel" key:@"yourHashKey"];
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

## Installation

Attention: A copy of DATAStack.swift is already included in this pod.

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

**EncryptedDATAStack** is available under the Affero GPL v3 Licence.\n
...Just kidding, MIT license for you. See the LICENSE file for more info.
