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


@end
