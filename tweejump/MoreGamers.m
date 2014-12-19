#import "MoreGamers.h"

@implementation MoreGamers

static MoreGamers *mgInstance;

+ (MoreGamers *)sharedInstance {
    if(mgInstance == nil) {
        mgInstance = [[super alloc] init];
    }
    return mgInstance;
}

- (id)init {
    if((self = [super init])) {
        mgId = 0;
        lastRequest = 0;
    }
    return self;
}

#pragma mark Instance Methods
- (void)Initialize:(int)myId {
    NSLog(@"MoreGamers.Initialize");
    
    mgId = myId;
    
    if(!mgWebView) {
        mgWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        mgWebView.delegate = self;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:mgWebView];
        mgWebView.hidden = YES;
    }
}
                      
- (void)Banner:(CGRect)pos {
    NSLog(@"MoreGamers.Banner");
    
    if(mgWebView) {
        CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
        if(now - lastRequest > 60) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.moregamers.com/ad/frame?id=%d", mgId]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [mgWebView loadRequest:request];
            lastRequest = now;
        }
        mgWebView.frame = pos;
        mgWebView.hidden = NO;
    }
}
                      
- (void)Hide {
    NSLog(@"MoreGamers.Hide");
    
    if(mgWebView) {
        mgWebView.hidden = YES;
    }
}

#pragma mark - WebView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if ([[url path] rangeOfString:@"/ad/frame"].location == 0) {
        NSLog(@"Loading initial URL");
        return YES;
    }
    [[UIApplication sharedApplication] openURL:url];
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
