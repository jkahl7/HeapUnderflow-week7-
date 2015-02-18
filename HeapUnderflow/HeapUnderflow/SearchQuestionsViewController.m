//
//  SearchQuestionsViewController.m
//  HeapUnderflow
//
//  Created by Josh Kahl on 2/16/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverflowService.h"
#import "QuestionCell.h"
#import "Question.h"

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
  
  [self.tableView registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:[NSBundle mainBundle]]
                                                    forCellReuseIdentifier:@"SEARCH_CELL"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  QuestionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SEARCH_CELL" forIndexPath:indexPath];
  
  Question *question = self.questions[indexPath.row];
  
  cell.questionText.text = question.questionText;
  
  
  //cell.imageView.image   = question.userAvatar;
  
  
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"row = %ld selected", indexPath.row);
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  //TODO: look into adding some regex here to clean up the search
  NSLog(@"searching for: %@",searchBar.text);
  [[StackOverflowService sharedService] fetchQuestionsWithSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSString *errorString) {
    //self.questions = [[NSArray alloc] initWithObjects:results, nil];
    self.questions = results;
    [self.tableView reloadData];
    NSLog(@"%lu",(unsigned long)self.questions.count);
  }];
}

@end
