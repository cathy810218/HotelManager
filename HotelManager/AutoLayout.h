//
//  AutoLayout.h
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface AutoLayout : NSObject

+ (NSArray *)fullScreenConstraintWithVFLForView:(UIView *)view;


+ (NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                       toView:(UIView *)superView
                                withAttribute:(NSLayoutAttribute)attribute
                                andMultiplier:(CGFloat)multiplier;

+ (NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                       toView:(UIView *)superView
                                withAttribute:(NSLayoutAttribute)attribute;

+ (NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view
                                               toView:(UIView *)otherView
                                       withMultiplier:(CGFloat)multiplier;

+ (NSLayoutConstraint *)leadingConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+ (NSLayoutConstraint *)trailingConstraintFrom:(UIView *)view
                                        toView:(UIView *)otherView;

+ (NSLayoutConstraint *)topConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+ (NSLayoutConstraint *)bottomConstraintFrom:(UIView *)view
                                        toView:(UIView *)otherView;

+ (NSLayoutConstraint *)height:(CGFloat)height
                       forView:(UIView *)view;

+ (NSLayoutConstraint *)width:(CGFloat)width
                      forView:(UIView *)view;

+ (NSLayoutConstraint *)centerYFrom:(UIView *)view
                             toView:(UIView *)otherView
                         withOffset:(CGFloat)offset;

+ (NSLayoutConstraint *)centerXFrom:(UIView *)view
                             toView:(UIView *)otherView
                         withOffset:(CGFloat)offset;

+ (NSLayoutConstraint *)offest:(CGFloat)offest
                forThisItemTop:(id)item
                 toThatItemTop:(id)otherItem;

+ (NSLayoutConstraint *)offest:(CGFloat)offest
                forThisItemTop:(id)item
              toThatItemBottom:(id)otherItem;

+ (NSLayoutConstraint *)offest:(CGFloat)offest
             forThisItemBottom:(id)item
              toThatItemBottom:(id)otherItem;

+ (NSLayoutConstraint *)offest:(CGFloat)offest
             forThisItemBottom:(id)item
                 toThatItemTop:(id)otherItem;


@end
