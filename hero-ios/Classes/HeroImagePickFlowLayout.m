//
//  HeroImagePickFlowLayout.m
//  hero
//
//  Created by 朱成尧 on 5/3/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroImagePickFlowLayout.h"
#import "common.h"
#define kImageHeight   79
#define kSpacingPadding 9.5
#define kTotalImageWidth 84
#define kOutSizeWidth 5

@implementation HeroImagePickFlowLayout

- (instancetype)init {
    if (!(self = [super init])) return nil;
    self.itemSize = CGSizeMake((SCREEN_W - 3) / 4, (SCREEN_W - 3) / 4);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
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
//    return NO;
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSMutableArray *attributes = [NSMutableArray array];
//    for (NSUInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
//    }
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *cellAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    cellAttributes.size = CGSizeMake(kTotalImageWidth, kTotalImageWidth);
//
//    return cellAttributes;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0;
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    attributes.alpha = 0;
//    attributes.transform3D = CATransform3DMakeScale(.1, .1, .1);
//    return attributes;
//}


@end
