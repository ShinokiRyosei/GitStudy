//
//  HomeViewController.swift
//  GitStudy
//
//  Created by ShinokiRyosei on 2016/10/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

import JEToolkit
import RealmSwift

class HomeViewController: UIViewController {
    
    fileprivate let cellMargin: CGFloat = 2.0
    fileprivate var contributions: Results<CommitNumber>?
    
    @IBOutlet private weak var collectionView: UICollectionView! {

        didSet {

            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerCellClass(HomeViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GitStudy"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contributions = CommitNumber.fetch()
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 365
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: HomeViewCell.self, for: indexPath) as! HomeViewCell
        if let contribution = contributions?.filter({ $0.createdAt.day() == indexPath.row }).first {
            cell.applyColor(of: true)
        }else {
            cell.applyColor()
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetail" {

            let destination = segue.destination as! CommitDetailViewController
            destination.model = sender as! CommitNumber
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {

    private func toSegue(sender: Any?) {

        self.performSegue(withIdentifier: "toDetail", sender: sender)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let contribution = contributions?.filter({ $0.createdAt.day() == indexPath.row }).first else {
            
            return
        }
        let model = CommitNumber.fetch(with: contribution.id)
        self.toSegue(sender: model)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / 14
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
