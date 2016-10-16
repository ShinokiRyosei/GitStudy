//
//  CommitRootViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Photos
import IoniconsKit
import JEToolkit

class CommitRootViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    let cellMargin: CGFloat = 2.0
    
    var photoAssets: PHAsset?
    
    var images: [UIImage] = []
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerCellClass(CommitRootViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDoneBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchAllImage()
    }
    
    func fetchAllImage() {
        PHAssetCollection.fetchMoments(with: nil).enumerateObjects(options: NSEnumerationOptions.concurrent) { (collection, _, _) in
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            assets.enumerateObjects(options: NSEnumerationOptions.concurrent, using: { (asset, index, stop) in
                self.photoAssets = assets.lastObject
                self.convertImage(with: assets.lastObject!)
            })
        }
    }
    
    func convertImage(with assets: PHAsset) {
        let imageManager = PHCachingImageManager()
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        options.isSynchronous = true
        imageManager.requestImageData(for: assets, options: options) { (data, string, orientation, anyHashable) in
            self.images.append(UIImage(data: data!)!)
            self.collectionView.reloadData()
        }
        self.imageView.image = images[0]
    }
    
    func setDoneBtn() {
        let rightBtn: UIBarButtonItem = UIBarButtonItem(title: String.ionicon(with: .androidCheckbox), style: .done, target: self, action: #selector(self.done))
        
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    func done() {
        self.performSegue(withIdentifier: "toCommitView", sender: self.imageView.image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCommitView" {
            let destination = segue.destination as! CommitViewController
            destination.image = self.imageView.image
        }
    }
}

extension CommitRootViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CommitRootViewCell.self, for: indexPath) as! CommitRootViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageView.image = images[indexPath.row]
    }
}

extension CommitRootViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / 3
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
}
