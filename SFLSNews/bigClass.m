//
//  bigClass.m
//  AVTEST
//
//  Created by 皓斌 朱 on 12-2-3.
//  Copyright 2012年 sfls. All rights reserved.
//

#import "bigClass.h"
#import "smallClass.h"
@implementation bigClass
@synthesize scrowView;
@synthesize bigClassList,xmlDocument;
-(void)xmlDocumentDelegateParsingFinished:(XMLDocument *)paramSender{
    NSArray *temparray=self.xmlDocument.rootElement.children;
    XMLelement *tempelement=[temparray objectAtIndex:0];
    NSLog(@"Parser finish the first data is %@",tempelement.text);
    self.bigClassList=self.xmlDocument.rootElement.children;
    int i;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        for (i=0; i<=[temparray count]-1; i++) {
            XMLelement *tempele=[self.bigClassList objectAtIndex:i];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"iphone_button.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"iphone_button_touched.png"] forState:UIControlEventTouchDown];
            button.frame=CGRectMake(40, i*(25+50)+70, 240, 50);
            NSMutableDictionary *tempid=tempele.attributes;
            button.titleLabel.text=tempele.text;
            button.titleLabel.font=[UIFont systemFontOfSize:20];
            [button setTitle:tempele.text forState:UIControlStateNormal];
            [button setTag:[[tempid objectForKey:@"id"] intValue]];
            [button addTarget:self action:@selector(toSmallClass:withTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrowView addSubview:button];
            
            NSString *a=[tempid objectForKey:@"id"];
            NSLog(@"%@,%@",a,[a floatValue]);
            NSLog(@"%@",a);
            //NSLog(@"the id is %@ ",[[tempid objectForKey:@"id"] intValue]);
            
        }
    }
    else{
        for (i=0; i<=[temparray count]-1; i++) {
            XMLelement *tempele=[self.bigClassList objectAtIndex:i];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"ipad_button.png"] forState:UIControlStateNormal];
            button.frame=CGRectMake(150, i*(50+100)+100, 480, 100);
            NSMutableDictionary *tempid=tempele.attributes;
            button.titleLabel.text=tempele.text;
            button.titleLabel.font=[UIFont systemFontOfSize:30];
            button.showsTouchWhenHighlighted=YES;
            [button setBackgroundImage:[UIImage imageNamed:@"ipad_button_touched.png"] forState:UIControlEventTouchDown];
            
            [button setTitle:tempele.text forState:UIControlStateNormal];
            [button setTag:[[tempid objectForKey:@"id"] intValue]];
            [button addTarget:self action:@selector(toSmallClass:withTag:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrowView addSubview:button];
            
            NSString *a=[tempid objectForKey:@"id"];
            NSLog(@"%@,%@",a,[a floatValue]);
            NSLog(@"%@",a);
            //NSLog(@"the id is %@ ",[[tempid objectForKey:@"id"] intValue]);
            
        }
        
    }
    
    
    [self.view addSubview:scrowView];
}
-(void)xmlDocumentDelegateParsingFailed:(XMLDocument *)paramSender withError:(NSError *)paramError{
    NSLog(@"Parse xml failed");
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //sleep(5);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.scrowView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"iphoneBak1.png"]];
    }
    else {
        self.scrowView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ipadBak1.png"]];
    }
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    NSString *xmlPath=@"http://app.sfls.cn/video_app/creatVideo_ipad_charge.asp?query=bigclass";
    
    XMLDocument *newDocument=[[XMLDocument alloc]initWithDelegate:self];
    self.xmlDocument=newDocument;
    [newDocument release];
    [self.xmlDocument parseRemoteXMLWithURL:xmlPath];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrowView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [scrowView release];
    [super dealloc];
}
- (IBAction)toSmallClass:(id)sender withTag:(int)tag{
    //NSLog(@"%@",[sender tag]);
    smallClass *smallclass=[[smallClass alloc]init];
    smallclass.title=[sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:smallclass animated:YES];
}
@end
