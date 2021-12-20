//
//  addDogDelegate.swift
//  My Dogs
//
//  Created by Safa Falaqi on 20/12/2021.
//

import Foundation
import UIKit

protocol AddDogDelegate: class{
    
    
    func addDog(by controller:ViewController, name n: String,color c:String ,treat t : String,image i:UIImage,at indexPath:NSIndexPath?)
}
