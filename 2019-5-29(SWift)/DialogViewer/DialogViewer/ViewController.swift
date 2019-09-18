//
//  ViewController.swift
//  DialogViewer
//
//  Created by 吉腾蛟 on 2019/9/18.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    private var sections: [[String: String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sections = [["header": "First Witch","content": "Hey,when will the three us meet up later?"],
                    ["header": "Second Witch","content": "When everything is straightened out."],
                    ["header": "Third Witch","content": "That will be just before sunset."],
                    ["header": "First Witch","content": "Where?"],
                    ["header": "Second Witch","content": "The dirt patch."],
                    ["header": "Third Witch","content": "I guess we will see Mac there."]]
        
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: "CONTENT")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HEADER")
        
        let layout = collectionView.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        
    }
    
    func wordsInSection(section: Int) -> [String] {
        let content = sections[section]["content"]
        let spaces = NSCharacterSet.whitespaces
        let words = content?.components(separatedBy: spaces)
        
        return words!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let words = wordsInSection(section: section)
        
        return words.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let words = wordsInSection(section: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CONTENT", for: indexPath) as! ContentCell
        cell.maxWidth = collectionView.bounds.size.width
        cell.text = words[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let words = wordsInSection(section: indexPath.section)
        let size = ContentCell.sizeForContentString(s: words[indexPath.row], forMaxwidth: collectionView.bounds.size.width)
        
        return size
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HEADER", for: indexPath) as!HeaderCell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = sections[indexPath.section]["header"]
            return cell
        }
        abort()
    }
}

