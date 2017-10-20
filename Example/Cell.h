//
//  Cell.h
//  dram
//
//  Created by emsihyo on 2017/6/3.
//  Copyright © 2017 emsihyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"
typedef NS_ENUM (NSInteger, CellStyle) {
    CellStyleUnknow,
    CellStyleSection0 = 1<<0,
    CellStyleSection1 = 1<<1,
    CellStyleEditing = 1<<2
};

@interface Cell : UICollectionViewCell
@property (nonatomic, strong) Channel *channel;
@property (nonatomic, assign) CellStyle style;

@end
