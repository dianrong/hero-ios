//
//  HeroUploadFlowLayout.m
//  hero
//
//  Created by 朱成尧 on 4/26/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//



#import "HeroUploadFlowLayout.h"

@interface HeroUploadFlowLayout ()

@end

@implementation HeroUploadFlowLayout

- (instancetype)init {
    if (!(self = [super init])) return nil;
    self.itemSize = CGSizeMake(kTotalImageWidth, kTotalImageWidth);
    self.minimumLineSpacing = kSpacingPadding / 2;
    self.minimumInteritemSpacing = kSpacingPadding - kOutSizeWidth;
    return self;
}

//- (void)prepareLayout {
//    [super prepareLayout];
//}
//
//- (CGSize)collectionViewContentSize {
//    return self.collectionView.frame.size;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//

@end
