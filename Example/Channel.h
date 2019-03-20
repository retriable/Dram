//
//  Channel.h
//  dram
//
//  Created by retriable on 2017/6/3.
//  Copyright © 2017 retriable. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Channel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isPersistent;

@end
