//
//  WSDetailPrep.h
//  Westminster
//
//  Created by Tom Hartley on 12/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "WSPrep.h"
#import "ASIHTTPRequest.h"
#import "UILabel+VerticalAlign.h"
#import "WSDataManager.h"
#import "WSColouredNavigationBar.h"

@interface WSDetailPrep : UIViewController <UIDocumentInteractionControllerDelegate, UIPrintInteractionControllerDelegate>{
    WSPrep *thePrep;
	UILabel *initialsLabel;
	UILabel *dueDate;
	UILabel *privateLabel;
	UILabel *attachmentLabel;
	UILabel *documentNameLabel;
	UIButton *downloadButton;
	TKProgressBarView *prog;
	BOOL fileDownloaded;
	UIDocumentInteractionController *docControl;
	UITextView *descriptionTextView;
	UIView *locationForProgressView;
	ASIHTTPRequest *req;
	IBOutlet WSColouredNavigationBar *navBar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil prep:(WSPrep *)prep;

@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UIView *locationForProgressView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UILabel *initialsLabel;
@property (nonatomic, retain) IBOutlet UILabel *dueDate;
@property (nonatomic, retain) IBOutlet UILabel *privateLabel;
@property (nonatomic, retain) IBOutlet UILabel *attachmentLabel;
@property (nonatomic, retain) IBOutlet UILabel *documentNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *downloadButton;
- (IBAction)downloadDocument:(id)sender;
-(void)documentDownloaded:(ASIHTTPRequest *)req;
-(void)documentDownloadFailed:(ASIHTTPRequest *)req;
- (IBAction)dismiss:(id)sender;

@end
