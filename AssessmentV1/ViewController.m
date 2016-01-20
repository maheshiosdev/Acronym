//
//  ViewController.m
//  AssessmentV1
//
//  Created by Mahesh on 20/01/16.
//  Copyright © 2016 Personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, retain)NSMutableArray *resultsArray;
@end

@implementation ViewController

@synthesize resultsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)searchButtonTapped:(id)sender {
    [self.inputField resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //http://www.nactem.ac.uk/software/acromine/dictionary.py
    NSString *url = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", self.inputField.text];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"\nError: \n%@", [error localizedDescription]);
        } else {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            
            if ([result isKindOfClass:[NSArray class]]) {
                resultsArray = [NSMutableArray arrayWithArray:result];
                [self.resultTableView reloadData];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
    [dataTask resume];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.inputField) {
        [self searchButtonTapped:textField];
    }
    
    return true;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return resultsArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dict = resultsArray[section];
    NSString *sectionTitle = [dict valueForKey:@"sf"];
    return sectionTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = resultsArray[section];
    NSArray *abbrArray = [dict valueForKey:@"lfs"];
    return abbrArray.count;//vars.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dict = resultsArray[indexPath.section];
    NSArray *abbrArray = [dict valueForKey:@"lfs"];
    NSDictionary *longformDict = abbrArray[indexPath.row];
    NSString *str = [longformDict valueForKey:@"lf"];
    
    NSNumber *freq = [longformDict valueForKey:@"freq"];
    NSNumber *since = [longformDict valueForKey:@"since"];
    NSString *descr = [NSString stringWithFormat:@"freq:%@ since:%@", freq, since];
    cell.textLabel.text = str;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.text = descr;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
