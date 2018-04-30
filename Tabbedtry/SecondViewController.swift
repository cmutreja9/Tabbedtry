//
//  SecondViewController.swift
//  Tabbedtry
//
//  Created by Chinky Mutreja on 30/4/18.
//  Copyright © 2018 Chinky Mutreja. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var Imageview: UIImageView!
    
    var image: UIImage?
   
    @IBAction func changeImage(_ sender: UIButton) {
        pickPhoto()
    }
    func pickPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            showPhotoMenu()
        }
        else{
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu(){
        let alert = UIAlertController(title: nil,message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel",style: .cancel,handler: nil)
        alert.addAction(cancel)
        
        let photo = UIAlertAction(title: "Use Camera",style: .default,handler: nil)
        alert.addAction(photo)
        
        let camRoll = UIAlertAction(title: "Use Camera Roll",style: .default,handler:{_ in self.choosePhotoFromLibrary()} )
        alert.addAction(camRoll)
        
        present(alert,animated: true,completion: nil)
    }
    func takePhotoWithCamera(){
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .camera
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        present(imagepicker,animated: true,completion: nil)
    }
    
    func choosePhotoFromLibrary(){
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        present(imagepicker,animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if let imageOne = image{
            showPhoto(image: imageOne)
        }
        dismiss(animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func showPhoto(image: UIImage){
        Imageview.image = image
        Imageview.isHidden = false
        Imageview.frame = CGRect(x: 10,y: 10,width: 200, height: 200)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

