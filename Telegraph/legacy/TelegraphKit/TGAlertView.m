#import "TGAlertView.h"

@interface TGAlertView () <UIAlertViewDelegate>

@property (nonatomic, copy) void (^completionBlock)(bool okButtonPressed);
@property (nonatomic, copy) void (^completBlock)(UIAlertView *alert,bool okButtonPressed);

@end

@implementation TGAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle completionBlock:(void (^)(bool okButtonPressed))completionBlock
{
    return [self initWithTitle:title message:(title == nil && iosMajorVersion() >= 8 && iosMinorVersion() < 1) ? [@"\n" stringByAppendingString:message] : message cancelButtonTitle:cancelButtonTitle otherButtonTitles:okButtonTitle == nil ? nil : @[okButtonTitle] completionBlock:completionBlock];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(void (^)(bool okButtonPressed))completionBlock
{
    self = [super initWithTitle:title message:(title == nil && iosMajorVersion() >= 8 && iosMinorVersion() < 1) ? [@"\n" stringByAppendingString:message] : message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self != nil)
    {
        for (NSString *otherButtonTitle in otherButtonTitles)
            [self addButtonWithTitle:otherButtonTitle];
        
        _completionBlock = completionBlock;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    return [super initWithTitle:title message:(title == nil && iosMajorVersion() >= 8 && iosMinorVersion() < 1) ? [@"\n" stringByAppendingString:message] : message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle completBlock:(void (^)(UIAlertView *alert,bool okButtonPressed))completionBlock
{
    return [self initWithTitle:title message:(title == nil && iosMajorVersion() >= 8 && iosMinorVersion() < 1) ? [@"\n" stringByAppendingString:message] : message cancelButtonTitle:cancelButtonTitle otherButtonTitles:okButtonTitle == nil ? nil : @[okButtonTitle] completBlock:completionBlock];
}
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completBlock:(void (^)(UIAlertView *alert,bool okButtonPressed))completionBlock
{
    self = [super initWithTitle:title message:(title == nil && iosMajorVersion() >= 8 && iosMinorVersion() < 1) ? [@"\n" stringByAppendingString:message] : message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self != nil)
    {
        for (NSString *otherButtonTitle in otherButtonTitles)
            [self addButtonWithTitle:otherButtonTitle];
        
        _completBlock = completionBlock;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_completionBlock != nil)
        _completionBlock(buttonIndex != alertView.cancelButtonIndex);
    
    if ((_completBlock != nil)) {
        _completBlock(alertView,buttonIndex != alertView.cancelButtonIndex);
    }
}

@end
