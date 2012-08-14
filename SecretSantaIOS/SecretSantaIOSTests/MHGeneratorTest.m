#import <SenTestingKit/SenTestingKit.h>
#import "MHGenerator.h"
#import "MHPerson.h"
#import "MHAssignment.h"

@interface MHGeneratorTest : SenTestCase 



@end

@implementation MHGeneratorTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testWhenTwoPeopleAreListedThenTheyAreBothSantasOfEachOther {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
    MHPerson *person2 = [[MHPerson alloc] initWithFirst: @"Askara" andLastName: @"Barnes"];
    
    MHGenerator *testObject = [[MHGenerator alloc] init];
    
    NSArray *assignments = [testObject createAssignmentsForPeople: @[person1, person2]];
    
    STAssertEquals(assignments.count, (NSUInteger) 2, nil);
    MHAssignment *assignment1 = [assignments objectAtIndex:0];
    MHAssignment *assignment2 = [assignments objectAtIndex:1];
    STAssertEqualObjects(assignment1.giver, person1, nil);
    STAssertEqualObjects(assignment1.recipient, person2, nil);
    STAssertEqualObjects(assignment2.giver, person2, nil);
    STAssertEqualObjects(assignment2.recipient, person1, nil);
}

- (void)testWhenSeveralPeopleAreMatchedThenEveryoneIsMatched {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
    MHPerson *person2 = [[MHPerson alloc] initWithFirst: @"Askara" andLastName: @"Barnes"];
    MHPerson *person3 = [[MHPerson alloc] initWithFirst: @"Aaron" andLastName: @"Chung"];
    
    MHGenerator *testObject = [[MHGenerator alloc] init];
    
    NSArray *people = @[person1, person2, person3];
    NSArray *assignments = [testObject createAssignmentsForPeople: people];
    NSArray *givers = [self giversFromAssignments:assignments];
    STAssertEqualObjects(givers, people, nil);
    NSArray *recipients = [self recipientsFromAssignments:assignments];
    STAssertTrue([recipients containsObject: person1], nil);
    STAssertTrue([recipients containsObject: person2], nil);
    STAssertTrue([recipients containsObject: person3], nil);
    STAssertFalse([self assignmentsContainSamePerson: assignments], nil);
}



- (NSArray *)giversFromAssignments: (NSArray *)assignments {
    NSMutableArray *givers = [NSMutableArray array];
    for (MHAssignment *assignment in assignments) {
        [givers addObject:assignment.giver];
    }
    return givers;
}

- (NSArray *)recipientsFromAssignments: (NSArray *)assignments {
    NSMutableArray *recipients = [NSMutableArray array];
    for (MHAssignment *assignment in assignments) {
        [recipients addObject:assignment.recipient];
    }
    return recipients;
}

- (BOOL)assignmentsContainSamePerson: (NSArray *)assignments {
    BOOL samePerson = NO;
    for (MHAssignment *assignment in assignments) {
        samePerson |= assignment.giver == assignment.recipient;
    }
    return samePerson;
}

- (BOOL)assignmentsContainTwoPeopleFromTheSameFamily: (NSArray *)assignments {
    BOOL sameFamily = NO;
    for (MHAssignment *assignment in assignments) {
        sameFamily |= [assignment.giver.lastName isEqualToString:assignment.recipient.lastName];
    }
    return sameFamily;
}



@end
