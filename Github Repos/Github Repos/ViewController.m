//
//  ViewController.m
//  Github Repos
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
        for (NSDictionary *repo in repos){
            NSString *repoName = repo[@"name"];
            NSLog(@"repo name: %@",repoName);
        }
        
    }];
    
    //The data task is created in a suspended state so we need to resume it
    [dataTask resume];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
