//
//  ViewController.h
//  SafeSharingTest
//
//  Created by Antonio Giarrusso on 25/03/13.
//  Copyright (c) 2013 Antonio Giarrusso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

    IBOutlet UITextField *UsernameField;
    IBOutlet UITextField *PasswordField;
}

-(IBAction)LoginAction:(id)sender;
-(IBAction)GetPasswordCard:(id)sender;
@end
