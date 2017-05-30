//
//  CommitRootViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

import JEToolkit
import TwicketSegmentedControl


// MARK: - CommitRootViewController

class CommitRootViewController: UIViewController {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet private weak var segmentedControl: TwicketSegmentedControl! {
        
        didSet {
            
            segmentedControl.delegate = self
            segmentedControl.setSegmentItems(Segment.titles())
        }
    }
    
    fileprivate let cellMargin: CGFloat = 2.0
    private var photoAssets: PHAsset?
    fileprivate var images: [UIImage] = []
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerCellClass(CommitRootViewCell.self)
        }
    }
    
    @IBOutlet private var cameraOutputView: UIView!
    @IBOutlet private var shutterButton: UIButton!
    
    private var input: AVCaptureDeviceInput!
    private var output: AVCapturePhotoOutput!
    private var session: AVCaptureSession!
    private var camera: AVCaptureDevice!
    
    fileprivate var albumView: UIView?
    fileprivate var cameraView: UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setDoneBtn()
        self.setNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchAllImage()
    }
    
    override func loadView() {
        self.albumView = UINib(nibName: "CommitRootAlbumView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        self.cameraView = UINib(nibName: "CommitRootCameraView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        
        if let view: UIView = self.albumView {
            self.view = view
        }
    }
    
    private func setupCamera() {
        
        session = AVCaptureSession()

    }
    
    private func setNavBar() {
        
        self.navigationController?.title = "Commit"
    }
    
    private func fetchAllImage() {
        
        PHAssetCollection.fetchMoments(with: nil).enumerateObjects(options: NSEnumerationOptions.concurrent) { (collection, _, _) in
            
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            assets.enumerateObjects(options: NSEnumerationOptions.concurrent, using: { (asset, index, stop) in
                self.photoAssets = assets.lastObject
                self.convertImage(with: assets.lastObject!)
            })
        }
    }
    
    private func convertImage(with assets: PHAsset) {
        
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
    
    private func setDoneBtn() {
    }
    
    @objc private func done() {
        
        self.performSegue(withIdentifier: "toCommitView", sender: self.imageView.image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCommitView" {
            
            let destination = segue.destination as! CommitViewController
            destination.image = self.imageView.image
        }
    }
}


// MARK: - UICollectionViewDataSource

extension CommitRootViewController: UICollectionViewDataSource {
    
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
}


// MARK: - UICollectionViewDelegate

extension CommitRootViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.imageView.image = images[indexPath.row]
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

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


// MARK: - TwicketSegmentedControlDelegate

extension CommitRootViewController: TwicketSegmentedControlDelegate {
    
    fileprivate enum Segment: Int {
        
        case photoLibrary
        case camera
        
        static func titles() -> [String] {
            
            return ["Library", "Camera"]
        }
    }
    
    func didSelect(_ segmentIndex: Int) {
        
    }
}
