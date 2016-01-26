#import "ACMConsentTaskResult.h"
#import <CloudMine/CloudMine.h>
#import "ORKResult+CloudMine.h"

@interface ACMConsentTaskResult ()
@property (nonatomic, nonnull) ORKTaskResult *taskResult;
@end

@implementation ACMConsentTaskResult

- (nonnull instancetype)initWithTaskResult:(ORKTaskResult * _Nonnull)taskResult
{
    self = [super init];
    if (nil == self || nil == taskResult) { return nil; }

    // Thoughts:
    // Subclass CMUser and add a createAccountWithConsent: method
    // This method could consume an ORKTaskResult, which it would wrap
    // and save. Or, instead of wrapping, it could call a new category method
    // added to ORKResult: acm_save. Interally ACM save could wrap the task and
    // save it. We need to consider how we'll set a proper value on the __class__ property.
    // This could probably be done by having the wrapper implement the + objectId method, (right method?)
    // For consent in particular, we'd want an easy way to access this if it will become a generalized
    // feature of the SDK. Perhaps this could be done with the ORK identifier property? Or perhaps
    // the consent wrapper should not use the would-be-generalized acm_save category method but instead
    // call save internally to implement this method. Actually, are the two mutually exclusive?


    // TODO: This is (potentially) where we could do inspection on the ORKTaskResult to ensure
    // it is a consent task and that the user did consent, although possibly the user abstraction
    // is actually the better place to handle that, and this class is invisible to users
    self.taskResult = taskResult;

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [self.taskResult encodeWithCoder:aCoder];
}

@end