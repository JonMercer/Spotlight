Set up note:
- YK tried the most recent version of Cocoapods, and it didn't work.
- So, I used 0.39.0, which worked.
- So, use: `sudo gem install cocoapods -v 0.39.0

Jon's Cocoapods Setup from scratch
- Quit Xcode
- `sudo gem install cocoapods` //needed for firebase
- `sudo gem install cocoapods -v 0.39.0` //needed for realm
- `pod install`
- Output should look like the following
```
spotlight$ pod install
Analyzing dependencies
Downloading dependencies
Installing Firebase (3.3.0)
Installing FirebaseAnalytics (3.2.1)
Installing FirebaseAuth (3.0.3)
Installing FirebaseDatabase (3.0.2)
Installing FirebaseInstanceID (1.0.7)
Installing GoogleInterchangeUtilities (1.2.1)
Installing GoogleNetworkingUtilities (1.2.1)
Installing GoogleParsingUtilities (1.1.1)
Installing GoogleSymbolUtilities (1.1.1)
Installing GoogleUtilities (1.3.1)
Installing Realm (1.0.1)
Installing RealmSwift (1.0.1)
```
- Launch the "Spotlight.xcworkspace" file from here on out (it's the white one)
