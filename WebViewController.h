#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

{
  @private
  NSString* url;
  UIWebView* webView;
  UIBarButtonItem* backButton;
  UIBarButtonItem* forwardButton;
}

-(id)initWithUrl:(NSString *)givenUrl;

@end
