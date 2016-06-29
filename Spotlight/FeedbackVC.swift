import UIKit
import RealmSwift

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}

class FeedbackVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // a simple function to test Realm.  This is just experimental!!  Making sure it works.
        testRealm();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func testRealm(){
        // Define your models like regular Swift classes

        // Use them like regular Swift objects
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name)")

        // Get the default Realm
        let realm = try! Realm()
        
        // Query Realm for all dogs less than 2 years old
        let puppies = realm.objects(Dog.self).filter("age < 2")
        print("puppies.count: \(puppies.count)")
        
        // Persist your data easily
        try! realm.write {
            realm.add(myDog)
        }

        print("after saving an object:")
        print("puppies.count: \(puppies.count)")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}