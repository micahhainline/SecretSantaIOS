#import "MHGenerator.h"
#import "MHPerson.h"
#import "MHAssignment.h"

@implementation MHGenerator

- (NSArray *) createAssignmentsForPeople: (NSArray *) people {
    NSMutableArray *assignments = [NSMutableArray array];
    for (int i = 0; i < people.count; i++) {
        MHPerson *person = [people objectAtIndex:i];
        MHAssignment *assignment = [[MHAssignment alloc] init];
        assignment.giver = person;
        assignment.recipient = [people objectAtIndex: (i + 1) % people.count];
        [assignments addObject:assignment];
    }
    
    return assignments;
}

@end
