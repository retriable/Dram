//
//  ViewController.m
//  dram
//
//  Created by retriable on 2017/6/3.
//  Copyright © 2017 retriable. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
@import Dram;
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *channels;
@property (nonatomic, strong) Channel *selectedChannel;
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChannels];
    [self setupCollectionView];
    [self setupButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupChannels {
    NSMutableArray *c0 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        Channel *channel = [[Channel alloc] init];
        channel.title = [NSString stringWithFormat:@"c:%d", i];
        [c0 addObject:channel];
    }
    NSMutableArray *c1 = [NSMutableArray array];
    for (int i = 10; i < 40; i++) {
        Channel *channel = [[Channel alloc] init];
        channel.title = [NSString stringWithFormat:@"c:%d", i];
        [c1 addObject:channel];
    }
    self.channels = [NSMutableArray array];
    [self.channels addObject:c0];
    [self.channels addObject:c1];
    self.selectedChannel = c0[0];
    self.selectedChannel.isSelected = YES;
    self.selectedChannel.isPersistent = YES;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((375-16*5)/4.0, 60);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) collectionViewLayout:layout];
    [self.collectionView registerClass:Cell.class forCellWithReuseIdentifier:NSStringFromClass(Cell.class)];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self.collectionView dram_setup];
    [self.view addSubview:self.collectionView];
    __weak typeof(self)weakSelf = self;
    self.collectionView.dram_can = ^BOOL (UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        if (sourceIndexPath.section == 0 && sourceIndexPath.item == 0) {
            //disable first item's movement
            return NO;
        }
        if (destinationIndexPath && destinationIndexPath.section == 0 && destinationIndexPath.item == 0) {
            //prevent a item to move to first
            return NO;
        }
        return YES;
    };
    self.collectionView.dram_dataSourceMovement = ^(UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        //datasource movement
        if (sourceIndexPath.section == destinationIndexPath.section) {
            NSMutableArray *channels = weakSelf.channels[sourceIndexPath.section];
            id obj = channels[sourceIndexPath.item];
            if (sourceIndexPath.item < destinationIndexPath.item) {
                if (destinationIndexPath.item < channels.count-1) {
                    [channels insertObject:obj atIndex:destinationIndexPath.item+1];
                } else {
                    [channels addObject:obj];
                }
                [channels removeObjectAtIndex:sourceIndexPath.item];
            } else {
                [channels insertObject:obj atIndex:destinationIndexPath.item];
                [channels removeObjectAtIndex:sourceIndexPath.item+1];
            }
        } else {
            NSMutableArray *sourceChannels = weakSelf.channels[sourceIndexPath.section];
            NSMutableArray *destinationChannels = weakSelf.channels[destinationIndexPath.section];
            if (destinationChannels.count > destinationIndexPath.item) {
                [destinationChannels insertObject:sourceChannels[sourceIndexPath.item] atIndex:destinationIndexPath.item];
            } else {
                [destinationChannels addObject:sourceChannels[sourceIndexPath.item]];
            }
            [sourceChannels removeObjectAtIndex:sourceIndexPath.item];
        }
    };
    self.collectionView.dram_began = ^void (UICollectionView *collectionView, NSIndexPath *sourceIndexPath, Cell *substituteCell) {
        if (!substituteCell) {
            return;
        }
        weakSelf.isEditing = YES;
        substituteCell.channel = weakSelf.channels[sourceIndexPath.section][sourceIndexPath.item];
        substituteCell.style = 1<<sourceIndexPath.section;
        substituteCell.style |= weakSelf.isEditing ? CellStyleEditing : 0;
        [UIView animateWithDuration:0.25 animations:^{
            substituteCell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        }];
    };

    self.collectionView.dram_ended = ^(UICollectionView *collectionView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath, Cell *substituteCell, Cell *cell) {
        if (cell.channel.isSelected && sourceIndexPath.section != destinationIndexPath.section) {
            cell.channel.isSelected = NO;
            weakSelf.selectedChannel = weakSelf.channels[0][0];
            weakSelf.selectedChannel.isSelected = YES;
        }
        [UIView animateWithDuration:0.25 animations:^{
            substituteCell.transform = CGAffineTransformIdentity;
            substituteCell.style = (substituteCell.style|(1<<sourceIndexPath.section))-(1<<sourceIndexPath.section)+(1<<destinationIndexPath.section);
            cell.style = (cell.style|(1<<sourceIndexPath.section))-(1<<sourceIndexPath.section)+(1<<destinationIndexPath.section);
        }];
    };
}

- (void)setupButton {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    [self.button setTitle:@"EDIT" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.button.frame = CGRectMake(150, 20, 75, 44);
    [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click {
    if (self.isEditing) {
        self.isEditing = NO;
    } else {
        self.isEditing = YES;
    }
}

- (void)setIsEditing:(BOOL)isEditing {
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
        if (_isEditing) {
            for (Cell *cell in self.collectionView.visibleCells) {
                cell.style |= CellStyleEditing;
            }
        } else {
            for (Cell *cell in self.collectionView.visibleCells) {
                cell.style = (cell.style|CellStyleEditing)-CellStyleEditing;
            }
        }
        [self.button setTitle:_isEditing ? @"DONE" : @"EDIT" forState:UIControlStateNormal];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.channels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.channels[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(Cell.class) forIndexPath:indexPath];
    cell.channel = self.channels[indexPath.section][indexPath.row];
    cell.style = 1<<indexPath.section;
    cell.style |= self.isEditing ? CellStyleEditing : 0;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(section ? 50 : 30, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.isEditing) {
            [collectionView dram_moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        } else {
            if (self.selectedChannel) {
                self.selectedChannel.isSelected = NO;
            }
            self.selectedChannel = self.channels[indexPath.section][indexPath.row];
            self.selectedChannel.isSelected = YES;
        }
    } else {
        [collectionView dram_moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:[self.channels[0] count] inSection:0]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
