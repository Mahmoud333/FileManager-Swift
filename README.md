# FileManager-Swift

[![CI Status](http://img.shields.io/travis/Mahmoud333/FileManager-Swift.svg?style=flat)](https://travis-ci.org/Mahmoud333/FileManager-Swift)
[![Version](https://img.shields.io/cocoapods/v/FileManager-Swift.svg?style=flat)](http://cocoapods.org/pods/FileManager-Swift)
[![License](https://img.shields.io/cocoapods/l/FileManager-Swift.svg?style=flat)](http://cocoapods.org/pods/FileManager-Swift)
[![Platform](https://img.shields.io/cocoapods/p/FileManager-Swift.svg?style=flat)](http://cocoapods.org/pods/FileManager-Swift)

## ScreenShots
![ScreenShot](https://github.com/Mahmoud333/FileManager-Swift/blob/master/screen1.PNG)
![ScreenShot](https://github.com/Mahmoud333/FileManager-Swift/blob/master/screen2.PNG)
![ScreenShot](https://github.com/Mahmoud333/FileManager-Swift/blob/master/screen3.PNG)
![ScreenShot](https://github.com/Mahmoud333/FileManager-Swift/blob/master/screen4.PNG)
![ScreenShot](https://github.com/Mahmoud333/FileManager-Swift/blob/master/screen4.PNG)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Why is it usefull
- Made entirely by code without using storyboard which makes it easier for anyone to use, implement and support all screen sizes

- useful for testing and released apps incase your app involves downloading contents/assets/files from url and you wanna see them or make the user able to delete any of the app contents if your app involves large assets like videos,3D objects

- you can enter folders/files and delete them

- you can see the real jpg, jepg, png images instead of image icons

- supports 3gp, files, jpg, json, mp4, pdf, png, txt, xml, zip images icon to be easier for you to navigate through the files

- Future features:

- Better UI with good animations
✓✓✓ you will get to see the real images instead of image icons 
- will be able to play/watch the videos, songs
- will be able to open and see what is inside json, xml, txt files


## How To Use 

```ruby
import FileManager_Swift

let fileManager = FileManagerVC()
present(fileManager, animated: true, completion: nil)
```
download the "Assets" folder in the example project and add it in your project if you want ur UI looks better those images are the images for json,txt,png and buttons images
-incase you want to change the image all you have to do is delete the original and add yours BUT WITH SAME NAME of the last image

also you can do

```ruby
//Shows subtitle that contains the size of file
customizations.cellType = CellType.titleAndSize

//Customize the header View Color
customizations.headerViewColor = UIColor.green
```

You don't need to do anything more

## Requirements
Swift 3 and 4 and IOS 9+ because its using NSLayoutAnchor

## Installation

FileManager-Swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FileManager-Swift"
```


## Author

Mahmoud333, mahmoud_smgl@hotmail.com

## License

FileManager-Swift is available under the MIT license. See the LICENSE file for more info.
