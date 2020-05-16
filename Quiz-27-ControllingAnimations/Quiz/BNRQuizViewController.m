//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by Enrique Aliaga on 10/28/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *questionLabelTrailingContainerConstraint;
@property (nonatomic, weak) NSLayoutConstraint *questionLabelCenterXContainerConstraint;
@property (nonatomic, weak) NSLayoutConstraint *questionLabelLeadingContainerConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *answerLabelCenterXContainerConstraint;
@property (nonatomic, weak) NSLayoutConstraint *answerLabelLeadingContainerConstraint;
@property (nonatomic, weak) NSLayoutConstraint *answerLabelTrailingContainerConstraint;

@end


@implementation BNRQuizViewController

#pragma mark - Controller life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Create two arrays filled with questions and answers
        // and make the pointers point to them
        
        self.questions = @[@"From what is cognac made?",
                           @"What is 7+7",
                           @"What is the capital of Vermont?"];
        
        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
    }
    
    // Return the address of the new object
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    // Constraint: Question Label.Center X = Superview.Center X
    NSLayoutConstraint *questionLabelCenterXContainerConstraint = [NSLayoutConstraint
        constraintWithItem:self.questionLabel attribute:NSLayoutAttributeCenterX
        relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX
        multiplier:1.0 constant:0.0];
    questionLabelCenterXContainerConstraint.priority = UILayoutPriorityDefaultLow;
    [self.view addConstraint:questionLabelCenterXContainerConstraint];
    
    // Constraint = Question Label.Leading = Superview.Trailing
    NSLayoutConstraint *questionLabelLeadingContainerConstraint = [NSLayoutConstraint
        constraintWithItem:self.questionLabel attribute:NSLayoutAttributeLeading
        relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing
        multiplier:1.0 constant:0.0];
    questionLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultLow;
    [self.view addConstraint:questionLabelLeadingContainerConstraint];
    
    // Constraint: Answer Label.Trailing = Superview.Leading
    NSLayoutConstraint *answerLabelTrailingContainerConstraint = [NSLayoutConstraint
        constraintWithItem:self.answerLabel attribute:NSLayoutAttributeTrailing
        relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading
        multiplier:1.0 constant:0.0];
    answerLabelTrailingContainerConstraint.priority = UILayoutPriorityDefaultLow;
    [self.view addConstraint:answerLabelTrailingContainerConstraint];
    
    // Constraint: Answer Label.Leading = Superview.Trailing
    NSLayoutConstraint *answerLabelLeadingContainerConstraint = [NSLayoutConstraint
        constraintWithItem:self.answerLabel attribute:NSLayoutAttributeLeading
        relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing
        multiplier:1.0 constant:0.0];
    answerLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultLow;
    [self.view addConstraint:answerLabelLeadingContainerConstraint];
    
    // Set labels' initial opacity
    self.questionLabel.alpha = 0.0;
    self.answerLabel.alpha = 1.0;
    
    self.questionLabelCenterXContainerConstraint = questionLabelCenterXContainerConstraint;
    self.questionLabelLeadingContainerConstraint = questionLabelLeadingContainerConstraint;
    self.answerLabelTrailingContainerConstraint = answerLabelTrailingContainerConstraint;
    self.answerLabelLeadingContainerConstraint = answerLabelLeadingContainerConstraint;
}

#pragma mark - UIButton actions

- (IBAction)showQuestion:(id)sender
{
    if (self.questionLabelCenterXContainerConstraint.priority == UILayoutPriorityDefaultHigh) {
        // Animate the disappearance of the old question... then display the new question.
        [self animateOldQuestionDeparture];
    } else {
        // This is the first question in the whole program. Animate its entrance.
        [self stepToNextQuestion];
        [self animateNewQuestionEntrance];
    }

    // Reset the answer label
    self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(id)sender
{
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 delay:0.0
        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationTransitionNone
        animations:^{
            // Placeholder answer will move from the center to the right edge of the screen,
            // until disappearing.
            self.answerLabelCenterXContainerConstraint.priority = UILayoutPriorityDefaultLow;
            self.answerLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultHigh;
                         
            // Placeholder answer will lose its opacity as it goes
            self.answerLabel.alpha = 0.0;
                         
            [self.view layoutIfNeeded];
        }
        completion:^(BOOL finished){
            // Get ready to display a new answer.
            self.answerLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultLow;
            self.answerLabelTrailingContainerConstraint.priority = UILayoutPriorityDefaultHigh;
                         
            // Answer the question.
            [self answerQuestion];
                         
            // Display the new answer!
            [self animateAnswerEntrance];
        }
     ];
}

#pragma mark - Internal

- (void)animateNewQuestionEntrance
{
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 animations:^{
        // New question will appear from the left edge of the screen, and move to the center.
        self.questionLabelTrailingContainerConstraint.priority = UILayoutPriorityDefaultLow;
        self.questionLabelCenterXContainerConstraint.priority = UILayoutPriorityDefaultHigh;
        
        // Animate new question's opacity from 0 to 1 on the way.
        self.questionLabel.alpha = 1.0;
        
        [self.view layoutIfNeeded];
    }];
}

- (void)animateOldQuestionDeparture
{
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 delay:0.0
        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationTransitionNone
        animations:^{
            // Old question will move from the center to the right edge of the screen,
            // until disappearing.
            self.questionLabelCenterXContainerConstraint.priority = UILayoutPriorityDefaultLow;
            self.questionLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultHigh;
            
            // Old question will lose its opacity as it goes
            self.questionLabel.alpha = 0.0;
            
            [self.view layoutIfNeeded];
        }
        completion:^(BOOL finished){
            // Get ready to display a new question.
            self.questionLabelLeadingContainerConstraint.priority = UILayoutPriorityDefaultLow;
            self.questionLabelTrailingContainerConstraint.priority = UILayoutPriorityDefaultHigh;
            
            // Display a new question!
            [self stepToNextQuestion];
            [self animateNewQuestionEntrance];
        }
     ];
}

- (void)animateAnswerEntrance
{
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 animations:^{
        // New answer will appear from the left edge of the screen, and move to the center.
        self.answerLabelTrailingContainerConstraint.priority = UILayoutPriorityDefaultLow;
        self.answerLabelCenterXContainerConstraint.priority = UILayoutPriorityDefaultHigh;
        
        // Animate new answer's opacity from 0 to 1 on the way.
        self.answerLabel.alpha = 1.0;
        
        [self.view layoutIfNeeded];
    }];
}

- (void)stepToNextQuestion
{
    // Step to the next question
    self.currentQuestionIndex++;
    
    // Am I past the last question?
    if (self.currentQuestionIndex == [self.questions count]) {
        // Go back to the first question
        self.currentQuestionIndex = 0;
    }
    
    // Get the string at that index in the questions array
    NSString *question = self.questions[self.currentQuestionIndex];
    
    // Display the string in the question label
    self.questionLabel.text = question;
}

- (void)answerQuestion
{
    // What is the answer to the current question?
    NSString *answer = self.answers[self.currentQuestionIndex];
    
    // Display it in the answer label
    self.answerLabel.text = answer;
}

@end
