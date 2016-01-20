//
//  ViewController.h
//  AssessmentV1
//
//  Created by Mahesh on 20/01/16.
//  Copyright © 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@end

