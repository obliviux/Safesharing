//
//  ViewControllerLog.m
//  SafeSharingTest
//
//  Created by Antonio Giarrusso on 26/03/13.
//  Copyright (c) 2013 Antonio Giarrusso. All rights reserved.
//

#import "ViewControllerLog.h"

@interface ViewControllerLog ()

@end

@implementation ViewControllerLog

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Welcome";

    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                     target:self
                                     action:@selector(ShowActionSheet)];
    self.navigationItem.rightBarButtonItem = actionButton;
    
    //check if safecard is installed and if we have already asked the user for this
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"safecard"]==TRUE && [safesharing SafecardisInstalled]) {
        
        [self ShowActionSheet];
    }
}

-(void)ShowActionSheet{
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Do you want to add your credentials to Safecard?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add to Safecard", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.navigationController.view];

}
-(IBAction)AddPasswordCard:(id)sender{

    
    //Check if Safecard is installed
    if ([safesharing SafecardisInstalled]) {
        
        UIImage *testImage = [UIImage imageNamed:@"testCard.png"]; //add your card image
        NSData *data = UIImageJPEGRepresentation(testImage, 0.7); 
        //Call this method to add a card in Safecard
        [safesharing AddPasswordCardWithKey:kPrivateKey Name:@"My Card Name" User:self.Username Password:self.Password Website:@"myappwebsite.com" FrontImageData:data];
        
        
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


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self AddPasswordCard:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"safecard"];
    } else if (buttonIndex == 1) {
       
    } 
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
