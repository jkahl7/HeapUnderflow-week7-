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
#import "AnswerViewController.h"

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
  self.tableView.rowHeight = UITableViewAutomaticDimension;
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
  
  cell.userImage.image = nil;
  if (!question.userAvatar)
  {
    [[StackOverflowService sharedService] fetchUserAvatar:question.imageURL
                                    withCompletionHandler:^(UIImage *image) {
      question.userAvatar  = image;
      cell.userImage.image = question.userAvatar;
    }];
    [cell reloadInputViews];
  } else {
    cell.userImage.image = question.userAvatar;
  }
  
  cell.userName.text     = question.userName;
  cell.questionText.text = question.questionText;
  
  if (question.answered)
  {
    cell.userName.textColor = [UIColor greenColor];
  } else {
    cell.userName.textColor = [UIColor redColor];
  }

  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  AnswerViewController *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AnswerVC"];
  
  Question *localQuestion = self.questions[indexPath.row];
  
  toVC.answerURL = localQuestion.answerURL;
  
  [self.navigationController pushViewController:toVC animated:YES];
  
  NSLog(@"row = %ld selected", indexPath.row);
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  //TODO: look into adding some regex here to clean up the search
  [[StackOverflowService sharedService] fetchQuestionsWithSearchTerm:searchBar.text
                                                   completionHandler:^(NSArray *results, NSString *errorString) {
    self.questions = results;
    [self.tableView reloadData];
    NSLog(@"%lu",(unsigned long)self.questions.count);
  }];
}

@end
