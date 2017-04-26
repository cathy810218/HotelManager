//
//  AutolayoutTest.m
//  HotelManager
//
//  Created by Cathy Oun on 4/26/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"

@interface AutolayoutTest : XCTestCase

@property (strong, nonatomic) UIViewController *testController;
@property (strong, nonatomic) UIView *testView1;
@property (strong, nonatomic) UIView *testView2;

@end

@implementation AutolayoutTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testView1 = [[UIView alloc] init];
    self.testView2 = [[UIView alloc] init];
    self.testController = [[UIViewController alloc] init];
    
    [self.testController.view addSubview:self.testView1];
    [self.testController.view addSubview:self.testView2];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testController = nil;
    self.testView1 = nil;
    self.testView2 = nil;
    
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGenericConstraintFromToViewAttribute
{
    XCTAssertNotNil(self.testController, @"The testController is nil");
    XCTAssertNotNil(self.testView1, @"The testController is nil");
    XCTAssertNotNil(self.testView2, @"The testController is nil");
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop];
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constraint is not an instance of NSLayoutConstraint");
    XCTAssertTrue([(NSLayoutConstraint *)constraint isActive], @"Constraint was not activated");
}

@end
