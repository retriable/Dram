//
//  Cell.m
//  dram
//
//  Created by retriable on 2017/6/3.
//  Copyright © 2017 retriable. All rights reserved.
//

#import "Cell.h"
#define rgba(r, g, b, a) [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: a]

@interface Cell ()

@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *editingView;

@end

@implementation Cell
- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor=rgba(arc4random()%256, arc4random()%256, arc4random()%256, 1);
        [self setupBg];
        [self setupLabel];
        [self setupEditingView];
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
    [self addObserver:self forKeyPath:@"channel.title" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"channel.isSelected" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"channel.isPersistent" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"style" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];

}

- (void)removeObservers {
    [self removeObserver:self forKeyPath:@"channel.title"];
    [self removeObserver:self forKeyPath:@"channel.isSelected"];
    [self removeObserver:self forKeyPath:@"channel.isPersistent"];
    [self removeObserver:self forKeyPath:@"style"];

}

- (void)setupBg {
    self.bg = [[UIView alloc] init];
    self.bg.layer.cornerRadius = 8.0;
    self.bg.layer.borderColor = rgba(88, 88, 88, 0.8).CGColor;
    self.bg.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.bg];

}

- (void)setupLabel {
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}

- (void)setupEditingView {
    self.editingView = [[UIView alloc] init];
    self.editingView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.editingView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bg.frame = CGRectInset(self.contentView.bounds, 4, 4);
    self.label.frame = self.bg.frame;
    self.editingView.frame = CGRectMake(CGRectGetMaxX(self.contentView.bounds)-20, CGRectGetMinY(self.contentView.bounds), 20, 20);
}

- (void)reDisplay {
    if (self.channel.isSelected && self.style&CellStyleSection0 && !(self.style&CellStyleEditing)) {
        self.label.textColor = rgba(255, 155, 26, 1);
    } else {
        self.label.textColor = rgba(55, 55, 55, 1);
    }
    if (self.style&CellStyleSection0) {
        self.bg.backgroundColor = rgba(255, 255, 255, 1);
    } else {
        self.bg.backgroundColor = rgba(240, 240, 240, 1);
    }
    if (self.style&CellStyleEditing && self.style&CellStyleSection0 && !self.channel.isPersistent) {
        self.editingView.alpha = 1;
    } else {
        self.editingView.alpha = 0;
    }
    self.label.text = self.channel.title;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    [self reDisplay];
}

@end




