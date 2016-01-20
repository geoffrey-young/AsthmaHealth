#import "ACMConsentDocument.h"

static NSString *const ACMSignatureIdentifier = @"ACMConsentParticipantConsentSignature";

@implementation ACMConsentDocument

// TODO: Ponder, is a subclass actually neccessary?
- (instancetype)init
{
    self = [super init];
    if (nil == self) return nil;

    self.sections = ACMConsentDocument.sections;

    ORKConsentSignature *signature = [ORKConsentSignature signatureForPersonWithTitle:nil dateFormatString:nil identifier:ACMSignatureIdentifier];
    [self addSignature:signature];

    return self;
}

#pragma mark Static Private Helpers

+ (NSArray<ORKConsentSection *> *)sections
{
    return @[self.welcomeSection, self.testSection];
}

+ (ORKConsentSection *)sectionWithType:(ORKConsentSectionType)type withTitle:(NSString *)title summary:(NSString *)summary andContent:(NSString *)content
{
    ORKConsentSection *section = [[ORKConsentSection alloc] initWithType:type];
    section.summary = summary;
    section.content = content;
    if (nil != title) { section.title = title; }

    return section;
}

+ (ORKConsentSection *)welcomeSection
{
    return [self sectionWithType:ORKConsentSectionTypeOverview
                       withTitle:nil
                          summary:NSLocalizedString(@"Mount Sinai is doing a research study about whether an asthma app on your iPhone will help you to monitor your asthma. This simple walkthrough will help you to understand the study, the impact it will have on your life, and will allow you to provide consent to participate.", nil)
                      andContent:NSLocalizedString(@"People with asthma do best if they actively manage their asthma. This app uses your mobile phone to help you do this. If you take daily asthma medicine, the app will help you remember to take it on schedule. There are links to learn more about asthma, how to use your medicine, what triggers your asthma, and how to recognize when your asthma is out of control. The information you put into the app will help you track how well your asthma is controlled and how you are doing compared to other app users with asthma. Although we will look at the data at different points during the study, we will not be looking at your asthma information each day. The app does not replace your usual medical care, so if your asthma is getting worse during the study, please reach out to your health care team", nil)];
}

+ (ORKConsentSection *)testSection
{
    return [self sectionWithType:ORKConsentSectionTypeCustom
                       withTitle:NSLocalizedString(@"We'll Test Your Understanding", nil)
                         summary:NSLocalizedString(@"We’ll walk you through some information on our Asthma research study, and  provide a short quiz at the end to confirm your understanding.", nil)
                      andContent:NSLocalizedString(@"Before completing the enrollment and creating your study account, we will assess your understanding and eligibility to provide consent. It is important that you understand what the study is about and what is involved. You should not join the research study until all of your questions are answered. Feel free to contact the study sponsor with any questions.", nil)];
}

@end
