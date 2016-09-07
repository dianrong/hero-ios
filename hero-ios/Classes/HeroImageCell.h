//
//  HeroImageCell.h
//  hero
//
//  Created by 朱成尧 on 5/3/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>

@class HeroImageCell;

@protocol HeroAsssetViewCellDelegate <NSObject>
@optional

- (void)didUpdateItemAssetsViewCell:(HeroImageCell *)assetsCell;

@end

@interface HeroImageCell : UICollectionViewCell

@property (nonatomic) NSURL *assetURL;
@property (nonatomic) BOOL isSelected;

@property (nonatomic, weak) id delegate;

- (void)setAssetURL:(NSURL *)assetURL isSelected:(BOOL)seleted;

@end
