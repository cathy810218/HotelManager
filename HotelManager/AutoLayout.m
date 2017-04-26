//
//  AutoLayout.m
//  HotelManager
//
//  Created by Cathy Oun on 4/24/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "AutoLayout.h"
#import <UIKit/UIKit.h>

@implementation AutoLayout

+ (NSArray *)fullScreenConstraintWithVFLForView:(UIView *)view
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *dict = @{@"view": view};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:dict];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:dict];
    [constraints addObjectsFromArray:horizontalConstraints];
    [constraints addObjectsFromArray:verticalConstraints];
    
    [NSLayoutConstraint activateConstraints:constraints]; // Need to activate them in order to work
    
    return [constraints copy];
}

+ (NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                       toView:(UIView *)superView
                                withAttribute:(NSLayoutAttribute)attribute
{
    return [AutoLayout genericConstraintFrom:view toView:superView withAttribute:attribute andMultiplier:1];
}

+ (NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                       toView:(UIView *)superView
                                withAttribute:(NSLayoutAttribute)attribute
                                andMultiplier:(CGFloat)multiplier
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:superView
                                                                  attribute:attribute
                                                                 multiplier:multiplier
                                                                   constant:0.0];
    
    constraint.active = YES;
    return constraint;
}

+ (NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view
                                               toView:(UIView *)otherView
                                       withMultiplier:(CGFloat)multiplier
{
    NSLayoutConstraint *heightConstraint = [AutoLayout genericConstraintFrom:view
                                                                      toView:otherView
                                                               withAttribute:NSLayoutAttributeHeight
                                                               andMultiplier:multiplier];
    
    return heightConstraint;
}

+ (NSLayoutConstraint *)leadingConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView
{
    return [AutoLayout genericConstraintFrom:view
                                      toView:otherView
                               withAttribute:NSLayoutAttributeLeading];
}

+ (NSLayoutConstraint *)trailingConstraintFrom:(UIView *)view
                                        toView:(UIView *)otherView
{
    return [AutoLayout genericConstraintFrom:view
                                      toView:otherView
                               withAttribute:NSLayoutAttributeTrailing];
}

+ (NSLayoutConstraint *)topConstraintFrom:(UIView *)view
                                   toView:(UIView *)otherView
{
    return [AutoLayout genericConstraintFrom:view
                                      toView:otherView
                               withAttribute:NSLayoutAttributeTop];
}

+ (NSLayoutConstraint *)bottomConstraintFrom:(UIView *)view
                                      toView:(UIView *)otherView
{
    return [AutoLayout genericConstraintFrom:view
                                      toView:otherView
                               withAttribute:NSLayoutAttributeBottom];
}


+ (NSLayoutConstraint *)centerXFrom:(UIView *)view toView:(UIView *)otherView withOffset:(CGFloat)offset
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0
                                                                  constant:offset];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)centerYFrom:(UIView *)view toView:(UIView *)otherView withOffset:(CGFloat)offset
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:offset];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)height:(CGFloat)height forView:(UIView *)view
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:height];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)width:(CGFloat)width forView:(UIView *)view
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:width];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)offest:(CGFloat)offest forThisItemTop:(id)item toThatItemTop:(id)otherItem
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:item
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherItem
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:offest];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)offest:(CGFloat)offest forThisItemTop:(id)item toThatItemBottom:(id)otherItem
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:item
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherItem
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:offest];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)offest:(CGFloat)offest forThisItemBottom:(id)item toThatItemBottom:(id)otherItem
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:item
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherItem
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:offest];
    constaint.active = YES;
    return constaint;
}

+ (NSLayoutConstraint *)offest:(CGFloat)offest forThisItemBottom:(id)item toThatItemTop:(id)otherItem
{
    NSLayoutConstraint *constaint = [NSLayoutConstraint constraintWithItem:item
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:otherItem
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:offest];
    constaint.active = YES;
    return constaint;
}
@end
