//
//  EMUserCell.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EMUserCell.h"

#import "EMImageView.h"
#import "EMBuddy.h"

CGFloat const EMUserCellPadding = 10;

@interface EMUserCell()

@property (nonatomic) NSLayoutConstraint *titleWithAvatarLeftConstraint;

@property (nonatomic) NSLayoutConstraint *titleWithoutAvatarLeftConstraint;

@end

@implementation EMUserCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EMUserCell *cell = [self appearance];
    cell.titleLabelColor = [UIColor blackColor];
    cell.titleLabelFont = [UIFont systemFontOfSize:18];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - private layout subviews

- (void)_setupSubview
{
    _avatarView = [[EMImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_avatarView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.numberOfLines = 2;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = _titleLabelFont;
    _titleLabel.textColor = _titleLabelColor;
    [self.contentView addSubview:_titleLabel];
    
    [self _setupAvatarViewConstraints];
    [self _setupTitleLabelConstraints];
}

#pragma mark - Setup Constraints

- (void)_setupAvatarViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EMUserCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EMUserCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EMUserCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}

- (void)_setupTitleLabelConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EMUserCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EMUserCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EMUserCellPadding]];
    
    self.titleWithAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EMUserCellPadding];
    self.titleWithoutAvatarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EMUserCellPadding];
    [self addConstraint:self.titleWithAvatarLeftConstraint];
}

#pragma mark - setter

- (void)setShowAvatar:(BOOL)showAvatar
{
    if (_showAvatar != showAvatar) {
        _showAvatar = showAvatar;
        self.avatarView.hidden = !showAvatar;
        if (_showAvatar) {
            [self removeConstraint:self.titleWithoutAvatarLeftConstraint];
            [self addConstraint:self.titleWithAvatarLeftConstraint];
        }
        else{
            [self removeConstraint:self.titleWithAvatarLeftConstraint];
            [self addConstraint:self.titleWithoutAvatarLeftConstraint];
        }
    }
}

- (void)setModel:(id<IUserModel>)model
{
    _model = model;
    
    if ([_model.nickname length] > 0) {
        self.titleLabel.text = _model.nickname;
    }
    else{
       self.titleLabel.text = _model.buddy.username;
    }
    
    if (_model.avatarImage) {
        self.avatarView.image = _model.avatarImage;
    }
    else if ([_model.avatarURLPath length] > 0){
        
    }
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = _titleLabelFont;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabelColor = titleLabelColor;
    _titleLabel.textColor = _titleLabelColor;
}

#pragma mark - class method

+ (NSString *)cellIdentifier
{
    return @"EMUserCell";
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return EMUserCellMinHeight;
}

@end