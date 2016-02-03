//
//  ViewController.m
//  Quiz
//
//  Created by Shiina Mashiro on 16/1/22.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (nonatomic) int currentQuestionIndex;
@property (copy, nonatomic) NSArray *questions;
@property (copy, nonatomic) NSArray *answers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questions = @[@"From what is cognac made?",
                       @"What is 7+7",
                       @"What is the capital of Vermont?"];
    self.answers = @[@"Grapes",
                     @"14",
                     @"Montpelier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showQuestion:(id)sender {
    self.currentQuestionIndex ++;
    if (self.currentQuestionIndex == [self.questions count]) self.currentQuestionIndex = 0;
    NSString *question  = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    self.answerLabel.text = @"???";
}
- (IBAction)showAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
}

@end
