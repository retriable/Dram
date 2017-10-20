//
//  UICollectionView+Dram.h
//  dram
//
//  Created by emsihyo on 2017/6/3.
//  Copyright © 2017 emsihyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Dram)

/**
   optional,return possibility of moving item from sourceIndexPath to destinationIndexPath.
 */
@property (nonatomic, copy) BOOL (^dram_can)(__kindof UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);

/**
   required,dataSource movement before moving cell.
 */
@property (nonatomic, copy) void (^dram_dataSourceMovement)(__kindof UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);

/**
    optional,began to move,long press was recognized or dram_moveItemAtIndexPath:toIndexPath: was called before.
 */
@property (nonatomic, copy) void (^dram_began)(__kindof UICollectionView *collectionView, NSIndexPath *sourceIndexPath, __kindof UICollectionViewCell *substituteCell);

/**
   optional,a movement was occurred.
 */
@property (nonatomic, copy) void (^dram_changed)(__kindof UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath, __kindof UICollectionViewCell *substituteCell);

/**
   optional,all movement was done.
 */
@property (nonatomic, copy) void (^dram_ended)(__kindof UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath, __kindof UICollectionViewCell *substituteCell, __kindof UICollectionViewCell *cell);


/**
   setup dram.
 */
- (void)dram_setup;

/**
   destroy dram.
 */
- (void)dram_destroy;


/**
   move item from sourceIndexPath to destinationIndexPath.

   @param sourceIndexPath sourceIndexPath
   @param destinationIndexPath destinationIndexPath
 */
- (void)dram_moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
