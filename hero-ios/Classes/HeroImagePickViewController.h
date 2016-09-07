//
//  HeroImagePickViewController.h
//  hero
//
//  Created by 朱成尧 on 4/26/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>
@class HeroImagePickViewController;

@protocol HeroImagePickViewControllerDelegate <NSObject>
@optional

- (void)heroImagePickViewController:(HeroImagePickViewController *)imagePick imagesAssets:(NSArray *)imagesAssets;
- (void)heroImagePickViewControllerDidCancel:(HeroImagePickViewController *)imagePick;

@end

@interface HeroImagePickViewController : UIViewController

- (instancetype)initWithGroupType:(ALAssetsGroupType)groupType delegate:(id)delegate;

@end
