//
//  ViewController.swift
//  My Dogs
//
//  Created by Safa Falaqi on 14/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogName: UITextField!
    
    @IBOutlet weak var dogColor: UITextField!
    
    @IBOutlet weak var addDog: UIButton!
    @IBOutlet weak var dogFav: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addPhotoBt: UIButton!
    
    var indexPath:NSIndexPath?
    var name:String?
    var treat:String?
    var color:String?
    var image:UIImage?
    
    weak var delegate:AddDogDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        
        
        dogName.text = name
        dogColor.text = color
        dogFav.text = treat
        if let i = image{
        imageView.image = i
            addDog.setTitle("Update Dog", for: .normal)
        }else{
            addDog.setTitle("Add Dog", for: .normal)
        }
    }

    @IBAction func didTapAddPhoto(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true )
    }
    
    @IBAction func addDogPressed(_ sender: UIButton) {
        delegate?.addDog(by: self, name: dogName.text!, color: dogColor.text!,treat: dogFav.text! , image: imageView.image!, at: indexPath)
        let alert = UIAlertController(title: "", message: "Dog added succsesfully ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
