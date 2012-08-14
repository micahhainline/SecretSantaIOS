#import "MHPerson.h"

@interface MHPerson()

@property (nonatomic, retain, readwrite) NSString *firstName;
@property (nonatomic, retain, readwrite) NSString *lastName;

@end

@implementation MHPerson

- (id) initWithFirst: (NSString *) first andLastName: (NSString *) last {
    if (self = [super init]) {
        self.firstName = first;
        self.lastName = last;
    }
    return self;
}

@end
