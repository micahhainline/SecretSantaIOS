#import <Foundation/Foundation.h>

@interface MHGenerator : NSObject

// Assignments for people should be in alphabetical order by giver's name
- (NSArray *) createAssignmentsForPeople: (NSArray *) people;
 
@end
