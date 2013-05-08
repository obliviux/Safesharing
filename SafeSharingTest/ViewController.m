//
//  ViewController.m
//  SafeSharingTest
//
//  Created by Antonio Giarrusso on 25/03/13.
//  Copyright (c) 2013 Antonio Giarrusso. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Login";
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GetCredentials:)
                                                 name:@"Safecard"
                                               object:nil];
    
}

-(void)GetCredentials:(NSNotification*)notific{
    NSArray *arrayCredentials = [notific object];
    
    if (arrayCredentials.count>1) {
        UsernameField.text = [arrayCredentials objectAtIndex:0];
        PasswordField.text = [arrayCredentials objectAtIndex:1];
        [self performSelector:@selector(LoginAction:) withObject:nil afterDelay:0.7];
    }
    
    if (arrayCredentials.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"No Credentials"
                              message: @"No credentials found on Safecard"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}


-(IBAction)GetPasswordCard:(id)sender{
    //Check if Safecard is installed
      if ([safesharing SafecardisInstalled]) {
          
          //Call this method to get username and/or password. Check in AppDelegate.m - handleOpenURL
    [safesharing GetPasswordCardWithKey:kPrivateKey];
          
          
      } else {
          UIAlertView *alert = [[UIAlertView alloc]
                                initWithTitle: @"ERROR"
                                message: @"The wonderful Safecard app is not installed"
                                delegate: nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
          [alert show];
      }
}

-(void)viewWillAppear:(BOOL)animated{
UsernameField.text=@"";
PasswordField.text=@"";
}

-(IBAction)LoginAction:(id)sender{
    
    if ([UsernameField.text isEqualToString:@"safecard"] && [PasswordField.text isEqualToString:@"awesome"]) {
    //Login correct
        ViewControllerLog *viewcontrollerlog = [[ViewControllerLog alloc] initWithNibName:@"ViewControllerLog" bundle:nil];
        viewcontrollerlog.Username=UsernameField.text;
        viewcontrollerlog.Password=PasswordField.text;
        [self.navigationController pushViewController:viewcontrollerlog animated:YES];

    } else {
    //Login incorrect
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"ERROR"
                              message: @"Login incorrect!"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
