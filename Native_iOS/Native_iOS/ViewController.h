//
//  ViewController.h
//  Native_iOS
//
//  Created by Dmitry Soldatenkov on 29/04/2019.
//  Copyright © 2019 TAU Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *mRunTest01;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest02;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest03;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest04;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest05;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest06;

- (IBAction)onPressRunTest01:(id)sender;
- (IBAction)onPressRunTest02:(id)sender;
- (IBAction)onPressRunTest03:(id)sender;
- (IBAction)onPressRunTest04:(id)sender;
- (IBAction)onPressRunTest05:(id)sender;
- (IBAction)onPressRunTest06:(id)sender;


// test 01
- (void)fillModelByTwoItems;
- (void)readAllItemsFromModel1;

// test 02
- (void)readValuesFromModel1ByFieldName;


// test 03
- (void)setupAndCallRubyNativeCallback;

// test 04
- (void)makeGetRequestToRubyServerAndReceiveResponce;

// test 05
- (void)complexJSONexample;



// test 06
- (void)restAPIexample;

@end

