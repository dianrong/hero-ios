//
//  HeroUploadCell.h
//  hero
//
//  Created by 朱成尧 on 4/26/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class HeroUploadCell;
@class HeroUploadItem;
@protocol HeroUploadCellDelegate <NSObject>
@optional

- (void)didDeleteItemUploadCell:(HeroUploadCell *)uploadCell;
- (void)didReUploadCell:(HeroUploadCell *)uploadCell;

@end

@interface HeroUploadCell : UICollectionViewCell

@property (nonatomic, weak) id<HeroUploadCellDelegate> delegate;

@property (nonatomic, weak) HeroUploadItem *uploaderItem;

@end
