#import <Foundation/Foundation.h>

@interface MHPerson : NSObject

- (id) initWithFirst: (NSString *) first andLastName: (NSString *) last;

@property (nonatomic, retain, readonly) NSString *firstName;
@property (nonatomic, retain, readonly) NSString *lastName;

@end
