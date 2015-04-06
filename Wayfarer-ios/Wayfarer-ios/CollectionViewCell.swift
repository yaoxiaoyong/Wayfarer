//
//  CollectionViewCell.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 4/3/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var id: UILabel!
    var backgroundImageView: UIImageView?
    
    var way: Way?
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.contentView.frame = self.bounds;
        self.contentView.backgroundColor = UIColor.clearColor();
        self.contentView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
    }
    
    func setImage(id: Int) {
        if (id == self.way?.id) {
            self.backgroundImageView = UIImageView(image: self.way?.image);
            self.backgroundView = self.backgroundImageView;
        }
    }
    
    
    func setWay(way: Way?) {
        self.way = way;
        if (way != nil) {
            self.title.text = self.way!.title.uppercaseString;
            self.id.text = "\(self.way!.id)";
        } else {
            self.title.text = "";
            self.id.text = "";
        }
    }
    
}
