//
//  ViewController.m
//  Native_iOS
//
//  Created by Dmitry Soldatenkov on 29/04/2019.
//  Copyright © 2019 TAU Technologies. All rights reserved.
//

#import "ViewController.h"


#import <Rhodes/Rhodes.h>




@interface RunTest01Task : NSObject <IRhoRubyRunnable> {
    ViewController* viewController;
}

@property (nonatomic,retain) ViewController* viewController;

- (void)rhoRubyRunnableRun;

@end

@implementation RunTest01Task

@synthesize viewController;

- (void)rhoRubyRunnableRun {
    NSLog(@"$$$ RunTest01Task.rhoRubyRunnableRun START");

    NSLog(@"$$$ add to Model1 two test items ...");
    [viewController fillModelByTwoItems];
    
    NSLog(@"$$$ check added items by read all items from Model1 ...");
    [viewController readAllItemsFromModel1];

    NSLog(@"$$$ RunTest01Task.rhoRubyRunnableRun FINISH");
}

@end


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mRunTest01;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest02;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest03;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest04;
@property (weak, nonatomic) IBOutlet UIButton *mRunTest05;
- (IBAction)onPressRunTest01:(id)sender;
- (IBAction)onPressRunTest02:(id)sender;
- (IBAction)onPressRunTest03:(id)sender;
- (IBAction)onPressRunTest04:(id)sender;
- (IBAction)onPressRunTest05:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) fillModelByTwoItems {
    NSLog(@"$$$ fillModelByTwoItems START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    [rr loadModel:@"Model1"];
    id<IRhoRubyObject>model1 = [rr makeRubyClassObject:@"Model1"];
    [rr executeRubyObjectMethod:model1 method_name:@"fillModelByPredefinedSet" parameters:nil];
    NSLog(@"$$$ fillModelByTwoItems FINISH");
}

-(void)readAllItemsFromModel1 {
    NSLog(@"$$$ readAllItemsFromModel1 START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    
    id<IRhoRubyObject>model1 = [rr makeRubyClassObject:@"Model1"];
    id<IRhoRubyObject>result = [rr executeRubyObjectMethod:model1 method_name:@"getAllItems" parameters:nil];
    
    id<IRhoRubyArray> ar = (id<IRhoRubyArray>)result;
    NSMutableString* str = [NSMutableString stringWithUTF8String:"[ "];
    
    int i;
    for (i = 0; i < [ar getItemsCount]; i++) {
        id<IRhoRubyObject>item = [ar getItemByIndex:i];
        id<IRhoRubyString>attr1 = (id<IRhoRubyString>)[rr executeRubyObjectMethod:item method_name:@"attr1" parameters:nil];
        id<IRhoRubyString>attr2 = (id<IRhoRubyString>)[rr executeRubyObjectMethod:item method_name:@"attr2" parameters:nil];
        id<IRhoRubyString>attr3 = (id<IRhoRubyString>)[rr executeRubyObjectMethod:item method_name:@"attr3" parameters:nil];
        
        [str appendString:@"< attr1 = \""];
        [str appendString:[attr1 getString]];
        
        [str appendString:@"\", attr2 = \""];
        [str appendString:[attr2 getString]];
        
        [str appendString:@"\", attr3 = \""];
        [str appendString:[attr3 getString]];
        
        [str appendString:@"\" >"];
        
        if (i < ([ar getItemsCount]-1)) {
            [str appendString:@", "];
        }
    }
    [str appendString:@" ]"];
    
    NSLog(@"$$$$$$$$$  readAllItemsFromModel1 RESULT : $$$$$$$$$$");
    NSLog(str);
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

    NSLog(@"$$$ readAllItemsFromModel1 FINISH");
}

- (IBAction)onPressRunTest01:(id)sender {
    NSLog(@"$$$ onPressRunTest01 START");

    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest01Task* task = [[RunTest01Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];
    
    NSLog(@"$$$ onPressRunTest01 FINISH");
}

- (IBAction)onPressRunTest02:(id)sender {
    NSLog(@"$$$ onPressRunTest02 START");
    NSLog(@"$$$ onPressRunTest02 FINISH");
}

- (IBAction)onPressRunTest03:(id)sender {
    NSLog(@"$$$ onPressRunTest03 START");
    NSLog(@"$$$ onPressRunTest03 FINISH");
}

- (IBAction)onPressRunTest04:(id)sender {
    NSLog(@"$$$ onPressRunTest04 START");
    NSLog(@"$$$ onPressRunTest04 FINISH");
}

- (IBAction)onPressRunTest05:(id)sender {
    NSLog(@"$$$ onPressRunTest05 START");
    NSLog(@"$$$ onPressRunTest05 FINISH");
}
@end
