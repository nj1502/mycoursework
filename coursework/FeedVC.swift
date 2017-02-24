//
//  FeedVC.swift
//  coursework
//
//  Created by Nathan Jayawardene on 2/23/17.
//  Copyright © 2017 Nathan Jayawardene. All rights reserved.
//

import UIKit
import Firebase //imports firebase
import SwiftKeychainWrapper //imports the swiftkeycahinwrapper framework.
//setting up the foundation for the table view

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
// displays the image picker
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageAdd: CircleView!
    @IBOutlet weak var captionField: FancyField!
    
    
       var posts = [Post]() //allows an continous array of posts
        var imagePicker: UIImagePickerController!
    
    
    //static var imageCache: Cache<NSString, UIImage> = Cache()
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    // creating a dictionary for string (url) reference as key and UIimage as data/theobject 
    var imageSelected = false
    
    
    

    override func viewDidLoad() { //view loading in memory
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //initializing the imagepicker
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self

        // imagePicker.allowediting - this allows the user to do basic image editing before they upload.
        
        
        
        
        
        // Do any additional setup after loading the view.
        //setting up listener to make sure that what ever changes is tracked (in the firebase atabase)
        // this function will access the posts attribute/object with the singleton. (down)
        // reffering to the posts attribute/child/object
        //.value looks for any value changes, this being whether there is a new child node is added, when a child node is removed, when a child node's location changes, when data changes at a location
        //this prints the snapshot (of the child object/attribute/entities and the value (what is contained in it)
        
        
    
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            // looking for snapshot form specific children object and then checking whether it is a firebase data snashot FIRDataSnapshot 
            //getting all data for each child 
            // attaining 3 objects
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {  //This is is essentially a listerner
                    print("SNAP: \(snap)")      // type SNAP to find when testing
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //assinged snapshot (data contained in key) to key constant
                        let post = Post(postKey: key, postData: postDict) //assings snapshot (of data contained in post object) to post constant
                        self.posts.append(post) // appending each post passed into the array
                    }
                }
            }
            self.tableView.reloadData() //reloading the data - making sure it is constantly referenceing and checking the firebase database.
    })
        
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        //returns integer of posts that are made in the array as the integer for tableView (for how many rows there will be)
    }
    
    
    
    
    //WHEN TESTING COMPARE VALUES IN TABLE TO THAT OF THE ACTUAL DATABASE on firebase
    //configurig tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //basically gets specific entities/child/objects (captions) from the posts object
        // get post from post array based on index path and then print captions specifically (ERROR handling to check whether it is working)
        
          let post = posts[indexPath.row]
        //creates a post cell
        
        // this actually adds the object retreived from post arritbute/Child/object to the visibile UI
        // adds number of likes, caption
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
        //configure cell to pass image in if the cache exists
        // if something is returnedif let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
            //checking whether something is the Cache
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
            } else { // this if let statement will pass the imagine (from a default value set in postcell
                cell.configureCell(post: post)
            }
            return cell
        } else {
            return PostCell()
        }
    }
            
            


    //TESTING CARRIED OUT FOR THISS CHECK BOTTOM LEFT SCREEN FOR NATHAN: ... (they will be captions
    
    
    
    
    
    
    //this funciton calls the image picker for user to pick image ot upload
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get image that user selected (array of information is recieved) - with in this array will be the edited image, checki image is UIimage.
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image //if it is UIimage then set image to the image of the button
            imageSelected = true
        } else {
            print("NATHAN: A valid image wasn't selected") //else display error message
        }
    imagePicker.dismiss(animated: true, completion: nil) //once user has selected an image get rid of the image picker
    }
    

    
    
    
    
    
    //when add image button is tapped
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        //guard creates a constant, and checks whether they post an image and a caption
        guard let caption = captionField.text, caption != "" else {
            //if this condition is not true then only if it is NOT true you carryout the code (unlike the if let) so if they dont post a caption
            print("NATHAN: Caption must be entered")
            return
        } //same principle applied as above, if they dont post an image this error message will be displayed
        guard let img = imageAdd.image, imageSelected == true else {
            //unless user goes into image picker and select an actual image will the boolean value be set to true
            print("NATHAN: An image must be selected")
            return
        }
          //this if let will actually upload the image 
        //img refers to the constant refered above, 0.2, is the compression quality of the image (to keep data usage down and maintain speed)
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            
            let imgUid = NSUUID().uuidString  //generates an unique ID for the string
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg" //so that the firebase database know what being passed to it.
            
            // sets some meta data for the image
//accesses the post-pics foler and posts image using an generated ID
            
            //using child value and putting data inside.
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("JESS: Unable to upload image to Firebasee torage")
                } else {
                    print("JESS: Successfully uploaded image to Firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString //metedata will get returned from completeion handle and it will contain the download url as an absolute string - (like the raw string so it will be exactly right)

                }
            }
        }
    }

    
    @IBAction func signOutTapped(_ sender: Any) { // if signin (actually signout) is tapped this will remove the key stored in key chain and perform a seqgue to the sign in screen
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
            print("NATHAN: ID REMOVED FROM KEY CHAIN\(keychainResult)")
        try! FIRAuth.auth()?.signOut()
     //try and catch method to make sure this message is displayed it the above action is not carried out. 
            performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    
    
    
    
    
    
        
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


