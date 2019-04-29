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





@interface RunTest02Task : NSObject <IRhoRubyRunnable> {
    ViewController* viewController;
}

@property (nonatomic,retain) ViewController* viewController;

- (void)rhoRubyRunnableRun;

@end

@implementation RunTest02Task

@synthesize viewController;

- (void)rhoRubyRunnableRun {
    NSLog(@"$$$ RunTest02Task.rhoRubyRunnableRun START");
    
    NSLog(@"$$$  receive values array from Model1 by field name...");
    [viewController readValuesFromModel1ByFieldName];
    
    NSLog(@"$$$ RunTest02Task.rhoRubyRunnableRun FINISH");
}

@end




@interface RunTest03Task : NSObject <IRhoRubyRunnable> {
    ViewController* viewController;
}

@property (nonatomic,retain) ViewController* viewController;

- (void)rhoRubyRunnableRun;

@end

@implementation RunTest03Task

@synthesize viewController;

- (void)rhoRubyRunnableRun {
    NSLog(@"$$$ RunTest03Task.rhoRubyRunnableRun START");
    
    NSLog(@"$$$  setup and call ruby native callback...");
    [viewController setupAndCallRubyNativeCallback];
    
    NSLog(@"$$$ RunTest03Task.rhoRubyRunnableRun FINISH");
}

@end


@interface Test03NativeCallbackReceiver : NSObject <IRhoRubyNativeCallback> {
}

-(void) onRubyNativeWithParam:(id<IRhoRubyObject>)param;

@end

@implementation Test03NativeCallbackReceiver

-(void) onRubyNativeWithParam:(id<IRhoRubyObject>)param {
    NSLog(@"$$$ Test03NativeCallbackReceiver.onRubyNativeWithParam START");
    
    // we expect a String
    id<IRhoRubyString> str_param = (id<IRhoRubyString>)param;
    NSLog(@"$$$ we receive from Ruby param = [%@]", [str_param getString]);
    
    
    NSLog(@"$$$ Test03NativeCallbackReceiver.onRubyNativeWithParam FINISH");
}

@end








@interface RunTest04Task : NSObject <IRhoRubyRunnable> {
    ViewController* viewController;
}

@property (nonatomic,retain) ViewController* viewController;

- (void)rhoRubyRunnableRun;

@end

@implementation RunTest04Task

@synthesize viewController;

- (void)rhoRubyRunnableRun {
    NSLog(@"$$$ RunTest04Task.rhoRubyRunnableRun START");
    
    NSLog(@"$$$  setup and call ruby native callback...");
    [viewController makeGetRequestToRubyServerAndReceiveResponce];
    
    NSLog(@"$$$ RunTest04Task.rhoRubyRunnableRun FINISH");
}

@end



@interface Test04RUbyServerReceiver : NSObject <IRubyLocalServerRequestCallback> {
}

-(void) onLocalServerResponce:(NSString*)responce;

@end

@implementation Test04RUbyServerReceiver

-(void) onLocalServerResponce:(NSString*)responce {
    NSLog(@"$$$ Test03NativeCallbackReceiver.onRubyNativeWithParam START");
    
    NSLog(@"$$$ we receive from Ruby Server next responce = [%@]", responce);
    
    NSLog(@"$$$ Test03NativeCallbackReceiver.onRubyNativeWithParam FINISH");
}

@end







@interface RunTest05Task : NSObject <IRhoRubyRunnable> {
    ViewController* viewController;
}

@property (nonatomic,retain) ViewController* viewController;

- (void)rhoRubyRunnableRun;

@end

@implementation RunTest05Task

@synthesize viewController;

- (void)rhoRubyRunnableRun {
    NSLog(@"$$$ RunTest05Task.rhoRubyRunnableRun START");
    
    NSLog(@"$$$  prepare JSON parameter, call Ruby and receive JSON result");
    [viewController complexJSONexample];
    
    NSLog(@"$$$ RunTest05Task.rhoRubyRunnableRun FINISH");
}

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)fillModelByTwoItems {
    NSLog(@"$$$ fillModelByTwoItems START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];
    id<IRhoRubyObject>model1 = [rr makeRubyClassObject:@"Model1"];
    [rr executeRubyObjectMethod:model1 method_name:@"fillModelByPredefinedSet" parameters:nil];
    NSLog(@"$$$ fillModelByTwoItems FINISH");
}

- (void)readAllItemsFromModel1 {
    NSLog(@"$$$ readAllItemsFromModel1 START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];

    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];

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
    NSLog(@"%@", str);
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

    NSLog(@"$$$ readAllItemsFromModel1 FINISH");
}

- (void)readValuesFromModel1ByFieldName {
    NSLog(@"$$$ readValuesFromModel1ByFieldName START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    
    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];
    
    id<IRhoRubyMutableString> fieldName = (id<IRhoRubyMutableString>)[rr makeBaseTypeObject:kRhoRubyMutableString];
    [fieldName setString:@"attr2"];
    
    id<IRhoRubyArray> values = (id<IRhoRubyArray>)[rr executeRubyMethod:@"Model1" method_name:@"getArrayWithAllValuesOfParamAllItemsByParamName" parameters:fieldName];
    
    NSMutableString* str = [NSMutableString stringWithUTF8String:"[ "];
    
    int i;
    for (i = 0; i < [values getItemsCount]; i++) {
        id<IRhoRubyString>value = (id<IRhoRubyString>)[values getItemByIndex:i];

        [str appendString:@"\""];
        [str appendString:[value getString]];
        [str appendString:@"\""];
        
        if (i < ([values getItemsCount]-1)) {
            [str appendString:@", "];
        }
    }
    [str appendString:@" ]"];
    
    NSLog(@"$$$$$$$$$  readValuesFromModel1ByFieldName RESULT (for field name = %@ ) : $$$$$$$$$$", [fieldName getString]);
    NSLog(@"%@", str);
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    NSLog(@"$$$ readValuesFromModel1ByFieldName FINISH");
}


- (void)setupAndCallRubyNativeCallback {
    NSLog(@"$$$ setupAndCallRubyNativeCallback START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    
    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];
    

    // setup ruby native callback
    Test03NativeCallbackReceiver* callback_reciver = [[Test03NativeCallbackReceiver alloc] init];
    [rr addRubyNativeCallback:callback_reciver callback_id:@"mySuperMegaRubyNativeCallbackID"];

    // call callback from ruby
    [rr executeRubyMethod:@"Model1" method_name:@"callRubyNativeCallback" parameters:nil];


    NSLog(@"$$$ setupAndCallRubyNativeCallback FINISH");
}


- (void)makeGetRequestToRubyServerAndReceiveResponce {
    NSLog(@"$$$ makeGetRequestToRubyServerAndReceiveResponce START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    
    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];
    
    // setup ruby server result receiver
    Test04RUbyServerReceiver* serverResponceReceiver = [[Test04RUbyServerReceiver alloc] init];
    // make get request
    [rr executeGetRequestToRubyServer:@"app/Model1/get_first_item_field_by_name?fieldName=attr3&param2example=74" callback:serverResponceReceiver];
    
    NSLog(@"$$$ makeGetRequestToRubyServerAndReceiveResponce FINISH");
}



- (void)complexJSONexample {
    NSLog(@"$$$ complexJSONexample START");
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    
    // ruby file should be loaded before using, if ruby file already loaded - nothing happens
    [rr loadModel:@"Model1"];
    

    // prepare first param - Hash with RhoRuby primitives
    id<IRhoRubyMutableHash> param_hash = (id<IRhoRubyMutableHash>)[rr makeBaseTypeObject:kRhoRubyMutableHash];
    
    // first element - array with two strings
    id<IRhoRubyMutableArray> param_array1 = (id<IRhoRubyMutableArray>)[rr makeBaseTypeObject:kRhoRubyMutableArray];
    
    id<IRhoRubyMutableString> param_array1_item1 = (id<IRhoRubyMutableString>)[rr makeBaseTypeObject:kRhoRubyMutableString];
    [param_array1_item1 setString:@"param_array1_item1_string_value"];
    [param_array1 addItem:param_array1_item1];
    
    id<IRhoRubyMutableString> param_array1_item2 = (id<IRhoRubyMutableString>)[rr makeBaseTypeObject:kRhoRubyMutableString];
    [param_array1_item2 setString:@"param_array1_item2_string_value"];
    [param_array1 addItem:param_array1_item2];
    
    [param_hash addItemWithKey:@"key1_array" item:param_array1];
    
    // second element - number
    id<IRhoRubyMutableInteger> param_number2 = (id<IRhoRubyMutableInteger>)[rr makeBaseTypeObject:kRhoRubyMutableInteger];
    [param_number2 setLong:1234567];
    [param_hash addItemWithKey:@"key2_integer" item:param_number2];
    
    // third element - boolean
    id<IRhoRubyMutableBoolean> param_bool3 = (id<IRhoRubyMutableBoolean>)[rr makeBaseTypeObject:kRhoRubyMutableBoolean];
    [param_bool3 setBool:YES];
    [param_hash addItemWithKey:@"key3_bool" item:param_bool3];
    
    // prepare second param - Float
    id<IRhoRubyMutableFloat> param_float = (id<IRhoRubyMutableFloat>)[rr makeBaseTypeObject:kRhoRubyMutableFloat];
    [param_float setDouble:0.12345];

    // prepare array of parameters - two parameter
    id<IRhoRubyMutableArray> params = (id<IRhoRubyMutableArray>)[rr makeBaseTypeObject:kRhoRubyMutableArray];
    [params addItem:param_hash];
    [params addItem:param_float];

    
    // convert Rhodes hash to JSON
    NSString* params_str = [rr convertObject_to_JSON:params];
    
    NSLog(@"$$$  Param JSON is = \"%@\"", params_str);
    
    // call ruby method and receive result in json
    NSString* result_json = [rr executeRubyMethodWithJSON:@"Model1" method_name:@"receiveAllItemAsArrayOfHashesWithParams" paramaters_in_json:params_str];
    
    NSLog(@"$$$ received from Ruby JSON result = \"%@\"", result_json);

    // convert JSON to Rhodes primitives and dump
    id<IRhoRubyArray> result_array = (id<IRhoRubyArray>)[rr convertJSON_to_Objects:result_json];
    
    // dump result from Rhodes primitives
    
    int i;
    NSLog(@"$$$   received result parsing :");
    for (i = 0; i < [result_array getItemsCount]; i++) {
        id<IRhoRubyHash> item_hash = (id<IRhoRubyHash>)[result_array getItemByIndex:i];
        NSString* attr1 = [((id<IRhoRubyString>)[item_hash getItemByKey:@"attr1"]) getString];
        NSString* attr2 = [((id<IRhoRubyString>)[item_hash getItemByKey:@"attr2"]) getString];
        NSString* attr3 = [((id<IRhoRubyString>)[item_hash getItemByKey:@"attr3"]) getString];
        NSLog(@"$$$            item[%@]  attr1=[%@], attr2=[%@], attr3=[%@]", [NSNumber numberWithInt:i], attr1, attr2, attr3);
    }
    NSLog(@"$$$   received result parsing DONE");
    

    NSLog(@"$$$ complexJSONexample FINISH");
}





- (IBAction)onPressRunTest01:(id)sender {
    NSLog(@"$$$ onPressRunTest01 START");
    NSLog(@"$$$ Simple test - add few items to model and read all model items - call ruby code and receive complex result - array of ruby objects");

    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest01Task* task = [[RunTest01Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];
    
    NSLog(@"$$$ onPressRunTest01 FINISH");
}

- (IBAction)onPressRunTest02:(id)sender {
    NSLog(@"$$$ onPressRunTest02 START");
    NSLog(@"$$$ Request array with all values of one field from all items by field name - call ruby code with params and receive result as array ");

    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest02Task* task = [[RunTest02Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];

    NSLog(@"$$$ onPressRunTest02 FINISH");
}

- (IBAction)onPressRunTest03:(id)sender {
    NSLog(@"$$$ onPressRunTest03 START");
    NSLog(@"$$$ Setup native callback in Ruby and call them by call ruby method ");

    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest03Task* task = [[RunTest03Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];


    NSLog(@"$$$ onPressRunTest03 FINISH");
}

- (IBAction)onPressRunTest04:(id)sender {
    NSLog(@"$$$ onPressRunTest04 START");
    NSLog(@"$$$ make GET request to Ruby server and receive responce ");
    
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest04Task* task = [[RunTest04Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];
    
    
    NSLog(@"$$$ onPressRunTest04 FINISH");
}

- (IBAction)onPressRunTest05:(id)sender {
    NSLog(@"$$$ onPressRunTest05 START");
    NSLog(@"$$$ prepare JSON parameters, call Ruby and receive result in JSON");
    
    id<IRhoRuby> rr = [RhoRubySingletone getRhoRuby];
    RunTest05Task* task = [[RunTest05Task alloc] init];
    task.viewController = self;
    [rr executeInRubyThread:task];
    
    NSLog(@"$$$ onPressRunTest05 FINISH");
}
@end
