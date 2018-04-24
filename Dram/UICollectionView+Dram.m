//
//  UICollectionView+Dram.m
//  dram
//
//  Created by emsihyo on 2017/6/3.
//  Copyright © 2017 emsihyo. All rights reserved.
//

#import "UICollectionView+Dram.h"
#import <objc/runtime.h>
static inline CGFloat dram_distanceBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat x = second.x - first.x;
    CGFloat y = second.y - first.y;
    return sqrt(x*x + y*y);
};

static inline CGPoint dram_centerOfFrame(CGRect frame) {
    return CGPointMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
};

@interface UICollectionView (Dram_)
/**
   long press gesture.
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *dram_longPress;
/**
   associated cell for  moving by long press.
 */
@property (nonatomic, strong) UICollectionViewCell *dram_associatedCell;
/**
   substitute cell for  moving by long press.
 */
@property (nonatomic, strong) UICollectionViewCell *dram_substituteCell;
/**
   source indexPath
 */
@property (nonatomic, strong) NSIndexPath *dram_sourceIndexPath;
/**
   destination indexPath
 */
@property (nonatomic, strong) NSIndexPath *dram_destinationIndexPath;
/**
   destination frame
 */
@property (nonatomic, assign) CGRect dram_destinationFrame;
/**
   latest location of long press gesture.
 */
@property (nonatomic, assign) CGPoint dram_latestLocation;
@end

@implementation  UICollectionView (Dram_)

- (UILongPressGestureRecognizer *)dram_longPress {
    return objc_getAssociatedObject(self, @selector(dram_longPress));
}

- (UICollectionViewCell *)dram_associatedCell {
    return objc_getAssociatedObject(self, @selector(dram_associatedCell));
}

- (UICollectionViewCell *)dram_substituteCell {
    return objc_getAssociatedObject(self, @selector(dram_substituteCell));
}

- (NSIndexPath *)dram_sourceIndexPath {
    return objc_getAssociatedObject(self, @selector(dram_sourceIndexPath));
}

- (NSIndexPath *)dram_destinationIndexPath {
    return objc_getAssociatedObject(self, @selector(dram_destinationIndexPath));
}

- (CGRect)dram_destinationFrame {
    return [objc_getAssociatedObject(self, @selector(dram_destinationFrame)) CGRectValue];
}

- (CGPoint)dram_latestLocation {
    return [objc_getAssociatedObject(self, @selector(dram_latestLocation)) CGPointValue];
}

- (void)setDram_longPress:(UILongPressGestureRecognizer *)dram_longPress {
    objc_setAssociatedObject(self, @selector(dram_longPress), dram_longPress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_associatedCell:(UICollectionViewCell *)dram_associatedCell {
    objc_setAssociatedObject(self, @selector(dram_associatedCell), dram_associatedCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_substituteCell:(UICollectionViewCell *)dram_substituteCell {
    objc_setAssociatedObject(self, @selector(dram_substituteCell), dram_substituteCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_sourceIndexPath:(NSIndexPath *)dram_sourceIndexPath {
    objc_setAssociatedObject(self, @selector(dram_sourceIndexPath), dram_sourceIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_destinationIndexPath:(NSIndexPath *)dram_destinationIndexPath {
    objc_setAssociatedObject(self, @selector(dram_destinationIndexPath), dram_destinationIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_destinationFrame:(CGRect)dram_destinationFrame {
    objc_setAssociatedObject(self, @selector(dram_destinationFrame), [NSValue valueWithCGRect:dram_destinationFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDram_latestLocation:(CGPoint)dram_latestLocation {
    objc_setAssociatedObject(self, @selector(dram_latestLocation), [NSValue valueWithCGPoint:dram_latestLocation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UICollectionView (Dram)

- (BOOL (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *))dram_can {
    return objc_getAssociatedObject(self, @selector(dram_can));
}

- (void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *))dram_dataSourceMovement {
    return objc_getAssociatedObject(self, @selector(dram_dataSourceMovement));
}

- (void (^)(__kindof UICollectionView *, NSIndexPath *, __kindof UICollectionViewCell *))dram_began {
    return objc_getAssociatedObject(self, @selector(dram_began));
}

- (void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *, __kindof UICollectionViewCell *))dram_changed {
    return objc_getAssociatedObject(self, @selector(dram_changed));
}

- (void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *, __kindof UICollectionViewCell *, __kindof UICollectionViewCell *))dram_ended {
    return objc_getAssociatedObject(self, @selector(dram_ended));
}

- (void)setDram_can:(BOOL (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *))dram_can {
    objc_setAssociatedObject(self, @selector(dram_can), dram_can, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDram_dataSourceMovement:(void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *))dram_dataSourceMovement {
    objc_setAssociatedObject(self, @selector(dram_dataSourceMovement), dram_dataSourceMovement, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDram_began:(void (^)(__kindof UICollectionView *, NSIndexPath *, __kindof UICollectionViewCell *))dram_began {
    objc_setAssociatedObject(self, @selector(dram_began), dram_began, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDram_changed:(void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *, __kindof UICollectionViewCell *))dram_changed {
    objc_setAssociatedObject(self, @selector(dram_changed), dram_changed, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDram_ended:(void (^)(__kindof UICollectionView *, NSIndexPath *, NSIndexPath *, __kindof UICollectionViewCell *, __kindof UICollectionViewCell *))dram_ended {
    objc_setAssociatedObject(self, @selector(dram_ended), dram_ended, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGSize)dram_scanSize {
    id obj = objc_getAssociatedObject(self, @selector(dram_scanSize));
    if (!obj) {
        CGFloat w, h;
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        w = layout.itemSize.width;
        h = layout.itemSize.height;
        NSParameterAssert(w && h);
        obj = [NSValue valueWithCGSize:CGSizeMake(w, h)];
        objc_setAssociatedObject(self, @selector(dram_scanSize), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [obj CGSizeValue];
}

- (NSIndexPath *)dram_indexPathAtPoint:(CGPoint)point {
    CGSize size = [self dram_scanSize];
    NSArray *arr = [self.collectionViewLayout layoutAttributesForElementsInRect:CGRectMake(point.x-size.width/2.0, point.y-size.height/2.0, size.width, size.height)];
    NSInteger idx = NSNotFound;
    CGFloat dis = CGFLOAT_MAX;
    for (NSInteger i = 0; i < arr.count; i++) {
        UICollectionViewLayoutAttributes *a = arr[i];
        CGPoint center = dram_centerOfFrame(a.frame);
        CGFloat distance = dram_distanceBetweenPoints(point, center);
        if (distance < dis) {
            dis = distance;
            idx = i;
        }
    }
    return arr.count ? [arr[idx] indexPath] : nil;
}

- (NSIndexPath *)dram_suggestedIndexPathAtPoint:(CGPoint)point {
    NSInteger section = NSNotFound;
    if ([(UICollectionViewFlowLayout *) self.collectionViewLayout scrollDirection] == UICollectionViewScrollDirectionVertical) {
        for (UICollectionViewCell *cell in self.visibleCells) {
            if (point.y > CGRectGetMinY(cell.frame) && point.y < CGRectGetMaxY(cell.frame)) {
                section = [self indexPathForCell:cell].section;
                break;
            }
        }
    } else {
        for (UICollectionViewCell *cell in self.visibleCells) {
            if (point.x > CGRectGetMinX(cell.frame) && point.x < CGRectGetMaxX(cell.frame)) {
                section = [self indexPathForCell:cell].section;
                break;
            }
        }
    }
    if (section == NSNotFound) {
        return nil;
    }
    return [NSIndexPath indexPathForItem:[self.dataSource collectionView:self numberOfItemsInSection:section] inSection:section];
}

- (BOOL)dram_canMoveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    BOOL can = YES;
    if (self.dram_can) {
        can = self.dram_can(self, sourceIndexPath, destinationIndexPath);
    }
    return can;
}

- (void)dram_setup {
    if (self.dram_longPress && [self.gestureRecognizers containsObject:self.dram_longPress]) {
        return;
    }
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dram_longPress:)];
    [self addGestureRecognizer:longPress];
    self.dram_longPress = longPress;
}

- (void)dram_destroy {
    if (self.dram_longPress) {
        [self removeGestureRecognizer:self.dram_longPress];
        self.dram_longPress = nil;
    }
}

- (void)dram_longPress:(UILongPressGestureRecognizer *)longPress {
    CGPoint location = [longPress locationInView:self];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self dram_began:location];
            break;
        case UIGestureRecognizerStateChanged:
            [self dram_changed:location];
            break;
        case UIGestureRecognizerStateEnded:
            [self dram_ended:location];
            break;
        default:
            break;
    }
}

- (void)dram_began:(CGPoint)location {
    NSIndexPath *sourceIndexPath = [self dram_indexPathAtPoint:location];
    if (!sourceIndexPath) {
        return;
    }
    if (![self dram_canMoveItemAtIndexPath:sourceIndexPath toIndexPath:nil]) {
        return;
    }
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:sourceIndexPath];
    cell.hidden = YES;
    UICollectionViewCell *substituteCell = [[cell.class alloc] initWithFrame:cell.frame];
    [self addSubview:substituteCell];
    if (self.dram_began) {
        self.dram_began(self, sourceIndexPath, substituteCell);
    }
    self.dram_associatedCell = cell;
    self.dram_substituteCell = substituteCell;
    self.dram_sourceIndexPath = sourceIndexPath;
    self.dram_destinationIndexPath = sourceIndexPath;
    self.dram_latestLocation = location;
    self.dram_destinationFrame = cell.frame;
}

- (void)dram_changed:(CGPoint)location {
    UICollectionViewCell *substituteCell = self.dram_substituteCell;
    if (!substituteCell) {
        return;
    }
    CGPoint latestLocation = self.dram_latestLocation;
    CGRect frame = substituteCell.frame;
    frame.origin.x += location.x-latestLocation.x;
    frame.origin.y += location.y-latestLocation.y;
    substituteCell.frame = frame;
    self.dram_latestLocation = location;
    NSIndexPath *sourceIndexPath = self.dram_destinationIndexPath;
    NSIndexPath *destinationIndexPath = [self dram_indexPathAtPoint:location];
    if (!destinationIndexPath) {
        destinationIndexPath = [self dram_suggestedIndexPathAtPoint:location];
        if (!destinationIndexPath || destinationIndexPath.section == sourceIndexPath.section) {
            return;
        }
    } else if (destinationIndexPath.section == sourceIndexPath.section && destinationIndexPath.item == sourceIndexPath.item) {
        return;
    }
    if (![self dram_canMoveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath]) {
        return;
    }
    self.dram_dataSourceMovement(self, sourceIndexPath, destinationIndexPath);
    [self moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    self.dram_destinationIndexPath = destinationIndexPath;
    self.dram_destinationFrame = [self cellForItemAtIndexPath:destinationIndexPath].frame;
    if (self.dram_changed) {
        self.dram_changed(self, sourceIndexPath, destinationIndexPath, substituteCell);
    }
}

- (void)dram_ended:(CGPoint)location {
    UICollectionViewCell *substituteCell = self.dram_substituteCell;
    if (!substituteCell) {
        return;
    }
    UICollectionViewCell *cell = [self dram_associatedCell];
    if (self.dram_ended) {
        self.dram_ended(self, self.dram_sourceIndexPath, self.dram_destinationIndexPath, substituteCell, cell);
    }
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        substituteCell.frame = self.dram_destinationFrame;
    } completion:^(BOOL finished) {
        [substituteCell removeFromSuperview];
        cell.hidden = NO;
        self.dram_substituteCell = nil;
        self.dram_sourceIndexPath = nil;
        self.dram_destinationIndexPath = nil;
        self.userInteractionEnabled = YES;
    }];

}

- (void)dram_moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (![self dram_canMoveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath]) {
        return;
    }
    if (self.dram_began) {
        self.dram_began(self, sourceIndexPath, nil);
    }
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:sourceIndexPath];
    [cell.superview bringSubviewToFront:cell];
    self.dram_dataSourceMovement(self, sourceIndexPath, destinationIndexPath);
    self.userInteractionEnabled = NO;
    [self performBatchUpdates:^{
        [self moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    if (self.dram_changed) {
        self.dram_changed(self, sourceIndexPath, destinationIndexPath, nil);
    }
    if (self.dram_ended) {
        self.dram_ended(self, sourceIndexPath, destinationIndexPath, nil, cell);
    }
}

@end





















