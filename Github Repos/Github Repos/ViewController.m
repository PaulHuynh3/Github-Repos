//
//  ViewController.m
//  Github Repos
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"
#import "RepoNameTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* repoNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/paulhuynh3/repos"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session  dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        //handle error
        if (error){
            NSLog(@"error:%@",error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        //handle error
        if (jsonError){
            NSLog(@"jsonError:%@",jsonError.localizedDescription);
        }
        
        //if we reach this point we have successfully received the api from json
        //we create a mutableArray inside to hold the json data
        NSMutableArray *infoRepoNameArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary *repo in repos){
            NSString *repoName = repo[@"name"];
            NSLog(@"repo name: %@",repoName);
            [infoRepoNameArray addObject:repo[@"name"]];
        }
        // even though we're inside this "frozen" block of code that isn't being run until later, inside of NSURLSession things
        // we can still access outside variables like `self`
        //access our array outside to hold the json data array.
        self.repoNameArray = [NSArray arrayWithArray:infoRepoNameArray];
        
        //this is the main thread.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        
            
        }];
        
    }];
    
    //The data task is created in a suspended state so we need to resume it
    [dataTask resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.repoNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RepoNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell configureWithRepoName:self.repoNameArray[indexPath.row]];
    
    return cell;
}



@end
