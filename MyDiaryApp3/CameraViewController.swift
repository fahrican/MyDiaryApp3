//
//  CameraViewController.swift
//  MyDiaryApp3
//
//  Created by fahri on 27.12.18.
//  Copyright © 2018 fahri. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func shareImageButton(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let items = [info[UIImagePickerController.InfoKey.originalImage] as? UIImage]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        picker.dismiss(animated: true, completion: nil)
        present(ac, animated: true)
    }
    

}
