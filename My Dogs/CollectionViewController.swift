//
//  CollectionViewController.swift
//  My Dogs
//
//  Created by Safa Falaqi on 14/12/2021.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController,AddDogDelegate,UICollectionViewDelegateFlowLayout {
    
    
    var dogs = [DogsItems]()
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
   // var dogsList

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      
        fetchAllItems()
    }
    
    func fetchAllItems(){
        let request: NSFetchRequest<DogsItems> = DogsItems.fetchRequest()
        do{
            dogs = try manageObjectContext.fetch(request)
           
        }catch{
            print("\(error)")
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
          if sender is UIBarButtonItem{
              let navigationController = segue.destination as! ViewController
              navigationController.delegate = self
          }else if sender is NSIndexPath{
            let navigationController = segue.destination as! ViewController
                navigationController.delegate = self

             let indexPath = sender as! NSIndexPath
              let item = dogs[indexPath.row]
              navigationController.name = item.name
              navigationController.color = item.color
              navigationController.image = UIImage(data:item.image!)
              navigationController.treat = item.treat
              navigationController.indexPath = indexPath

         }
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ItemSegue", sender: sender)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCollectionViewCell
    
        // Configure the cell
        cell.dogImage.image = UIImage(data:dogs[indexPath.row].image!)
  
        return cell
    }

    
    
    func addDog(by controller: ViewController, name n: String, color c: String,treat t:String , image i: UIImage, at indexPath: NSIndexPath?) {
        
       if let ip = indexPath{
            let item = dogs[ip.row]
           item.name = n
           item.color = c
           item.treat = t
           item.image = i.pngData()
        }else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "DogsItems", into: manageObjectContext) as! DogsItems
            item.name = n
            item.color = c
            item.image = i.pngData()
            item.treat = t
            dogs.append(item)
      }
        saveContext()
        
        collectionView.reloadData()
        dismiss(animated: true)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
    
}
