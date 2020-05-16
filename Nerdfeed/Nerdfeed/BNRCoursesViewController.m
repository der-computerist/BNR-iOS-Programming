//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by Enrique Aliaga Chavez on 12/19/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

@interface BNRCoursesViewController () <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end


@implementation BNRCoursesViewController

#pragma mark - Controller life cycle

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        self.navigationItem.title = @"BNR Courses";

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];

//        [self fetchFeed];  // uncomment for real data
        [self getMockFeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    
    if (!self.splitViewController) {
        [self.navigationController pushViewController:self.webViewController animated:YES];
    }
}

#pragma mark - NSURLSession task delegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
    didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
    completionHandler:
        (void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch"
        password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];

    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

#pragma mark - Internal

- (void)fetchFeed
{
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *URL = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask =
        [self.session dataTaskWithRequest:req
                        completionHandler:
            ^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:0
                                                                             error:nil];
                self.courses = jsonObject[@"courses"];
                
                NSLog(@"%@", self.courses);

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
    [dataTask resume];
}

- (void)getMockFeed
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"courses" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:nil];
    self.courses = jsonObject[@"courses"];

    NSLog(@"%@", self.courses);
}

@end
