#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithUrl:(NSString *)givenUrl
{
  self = [super init];
  if (self) {
    url = givenUrl;
  }
  return self;
}

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
  webView = [[UIWebView alloc] init];
  webView.delegate = self;
  CGFloat tabBarHeight = [[[self tabBarController] rotatingFooterView] frame].size.height;
  CGFloat navigationBarHeight = 44;
  webView.frame = CGRectMake(0, navigationBarHeight, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] applicationFrame].size.height - tabBarHeight);
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  webView.scalesPageToFit = YES;
  [self.view addSubview:webView];
  NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
  [webView loadRequest:request];

  UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, navigationBarHeight)];
  [self.view addSubview:toolBar];
  backButton    = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(onTapBackButton:)];
  backButton.enabled    = NO;
  forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"進む" style:UIBarButtonItemStyleBordered target:self action:@selector(onTapForwardButton:)];
  forwardButton.enabled = NO;
  toolBar.items = [NSArray arrayWithObjects:backButton, forwardButton, nil];
  toolBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)onTapBackButton:(id)inSender
{
  if (webView.canGoBack) {
    [webView goBack];
  }
}

- (void)onTapForwardButton:(id)inSender
{
  if (webView.canGoForward) {
    [webView goForward];
  }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)givenWebView
{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

  if (webView.canGoBack) {
    backButton.enabled = YES;
  }
  else {
    backButton.enabled = NO;
  }
  if (webView.canGoForward) {
    forwardButton.enabled = YES;
  }
  else {
    forwardButton.enabled = NO;
  }
}

@end
