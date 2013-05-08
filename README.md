# Safesharing

The Safesharing framework allows App Developers to integrate the [Safecard app](http://safecardapp.com) in a simple and quick way.
<br /><br /><br />
# What is this?
---
This is a sample app that shows how you can use the Safesharing framework to save and load  user's credentials with the [Safecard app](http://safecardapp.com). Here is a demonstrative video:

http://youtu.be/Y6ScYfzBaa8

<br /><br /><br />
# Why I should use it?
---
Because you can add a Password card, with the user's credentials, from your app directly into [Safecard](http://safecardapp.com). You can also access these data anytime.

This is useful to allow users to make faster logins without having to remember so many different logins or passwords.

The user simply tap on your **Login with Safecard** button, and, if the credentials are saved into the app, * **BAM** *, he is logged in.

####5 reasons to use Safesharing
* It's Quick, Safe and Free.
* The user must remember only one password for all of its app, although he used different credentials.
* The login is done by inserting a 5-digit password, which is faster than enter username and/or an alphanumeric password.
* The user can have an organized list of all his credentials within [Safecard](http://safecardapp.com).
* If the user has deleted your app, he has always a backup of his credentials into [Safecard](http://safecardapp.com). Your website is saved too.


<br /><br /><br />
# Installation in your app
---
It's really simple and requires 5 minutes! Follow these steps.

#### Add the necessary files
Drag ```Safesharing.framework``` and ```safesharing.h``` into your app. Add to target.

Add the ```Security.framework```:

1. In the project navigator, select your project
2. Select your target
3. Select the ‘Build Phases’ tab
4. Open ‘Link Binaries With Libraries’ expander
5. Click the ‘+’ button
6. Select and add the ```Security.framework```

Now ```#import "safesharing.h"``` in your ```YourAppName-prefix.pch```.

#### Set your app URL Scheme
<br />
![Url Scheme](http://i.stack.imgur.com/OMMcP.png)
<br /><br />

* Open "Supporting Files" (folder) on left and click the ```YourAppName-Info.plist```
* Choose a row like "Bundle creator OS Type Code" and mouse over row and click the (+) symbol
* This creates a new row and type ```URL types```
* Click the arror to left and see Item 0 and you'll rename the value in Item 0 to ```URL Schemes``` as shown
* Then edit the field in Item 0 and type in your URL Scheme. 


Choose an URL Scheme that identifies your app unequivocally.


#### Set your PrivateKey
Open ```safesharing.h``` and modify the ```kPrivateKey``` default value with a **strong password**. This will ensure that only your app can read and decrypt the data.
<br /><br /><br />
# How to use
---
In this test project you will find a complete app with all the information you need. The available methods are:

#### Check if Safecard is installed
You can improve the user experience by checking that [Safecard](http://safecardapp.com) is installed and choose accordingly the action to take. For example, you can advise the user to install [Safecard](http://safecardapp.com) or hide the "Login with Safecard" button.

```
if ([safesharing SafecardisInstalled]){
//Safecard is installed
} else {
//Safecard is not installed
//Y U NO INSTALL SAFECARD?
}
```

#### Add a Password Card
The Safesharing framework allows you to add a card with the user's credentials in a fast and simple way. Just choose the Card Name, the image of the card, the website and add the user's credentials.

```
[safesharing AddPasswordCardWithKey:kPrivateKey Name:@"My Card Name" User:self.Username Password:self.Password Website:@"myappwebsite.com" FrontImageData:data];
```


#### Request credentials
This is how the **Login with Safecard** button works. This method will open the [Safecard app](http://safecardapp.com) and, after entering the password, the user's credentials will be taken and brought into your app.

```
[safesharing GetPasswordCardWithKey:kPrivateKey];
```

After your app has been re-opened from [Safecard](http://safecardapp.com), you will receive an **NSArray**. So, in your ```AppDelegate.m```:


```
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (!url) {
        return NO; }
    
    NSString *URLString = [url absoluteString];
    if ([URLString rangeOfString:@"safeshare"].location == NSNotFound) {
    } else {
   //we just come back from Safecard
   
        //Received username and/or password
        NSArray *credentials = [safesharing ReceivedSafesharingDataWithKey:kPrivateKey];
    
    }
    
    return YES;
}
```
This array contains the user's credentials, which you can use to login automatically.

<br /><br /><br />
# About Security
---
The Safesharing framework, as the name suggests, is very safe. It **encrypts** the user's credentials before, during and after the communications between apps. When the communication is over, the data are deleted. The encryption system is the same used by Safecard: **AES 256-bit**, one of the safest security systems in the world.

Furthermore, only your app can access the saved credentials, and, on the other hand, it can not access the credentials stored by other apps.

To ensure the best data security remember to create a **strong PrivateKey** and **do not share this key** with anyone.

<br /><br /><br />
# License
---

Copyright (C) 2013-2014 Antonio Giarrusso. All rights reserved.

Redistribution **and use** in source **and** binary forms, with **or** without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions **and** the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions **and** the following disclaimer in the documentation
   **and/or** other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS **"AS IS"**
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
