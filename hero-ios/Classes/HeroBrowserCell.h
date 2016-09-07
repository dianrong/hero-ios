//
//  HeroBrowserCell.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeroPhotoBrowerViewController;
@interface HeroBrowserCell : UICollectionViewCell

@property (nonatomic, weak) HeroPhotoBrowerViewController *photoBrowser;
@property (nonatomic) NSURL *assetURL;

@end
