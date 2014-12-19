#import <Foundation/Foundation.h>

@interface MoreGamers : NSObject <UIWebViewDelegate>
{
    int mgId;
    UIWebView *mgWebView;
    CFAbsoluteTime lastRequest;
}

+(id)sharedInstance;
-(void)Initialize:(int)myId;
-(void)Banner:(CGRect)pos;
-(void)Hide;

@end
