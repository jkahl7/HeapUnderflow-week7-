//
//  SearchQuestionsViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "SearchQuestionsViewController.h"

@interface SearchQuestionsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *questions;

@end


@implementation SearchQuestionsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.delegate   = self;
  self.tableView.dataSource = self;
  self.searchBar.delegate   = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //TODO: implement QuestionCell
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SEARCH_CELL" forIndexPath:indexPath];
  
  cell.textLabel.text = @"default";
  
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"row = %ld selected", indexPath.row);
}


@end
