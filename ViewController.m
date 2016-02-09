//
//  ViewController.m
//  UnitConverter
//
//  Created by Mahesh on 10/10/15.
//  Copyright © 2015 Mahesh. All rights reserved.
//

#import "ViewController.h"

double convertTonnesToKgs(double Tonnes)

{
    double Kgs;
    
    Kgs = Tonnes * 1000 ;
    return  Kgs;
}

double convertTonnesTogms(double Tonnes)

{
    double gms;
    
    gms = Tonnes * 1000000 ;
    return  gms;
}

double convertTonnesTomilligms(double Tonnes)
{
    double milligms;
    
    milligms = Tonnes * 1000000000 ;
    return  milligms;
}
    


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputFeild;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UILabel *outputFeild;



@end

@implementation ViewController

- (IBAction)updateButton:(id)sender {
    
    NSMutableString * buf = [NSMutableString new];
    double userInput = [self.inputFeild.text doubleValue];
    
    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        double kgs = convertTonnesToKgs(userInput);
        [buf appendString:[@(kgs) stringValue]];
    }
    
    else if (self.segmentControl.selectedSegmentIndex == 1)
    {
        double gms = convertTonnesTogms(userInput);
        [buf appendString:[@(gms) stringValue]];
    }
    else
    {
        double milligms = convertTonnesTomilligms(userInput);
        [buf appendString:[@(milligms) stringValue]];
    }

    self.outputFeild.text = buf ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
