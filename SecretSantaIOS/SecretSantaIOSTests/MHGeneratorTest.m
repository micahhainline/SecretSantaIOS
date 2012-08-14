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

- (void)testWhenPeopleWithTheSameNameAreAddedThenAssignmentsDoNotContainFamilyMembers {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
    MHPerson *person2 = [[MHPerson alloc] initWithFirst: @"Bob" andLastName: @"Arlington"];
    MHPerson *person3 = [[MHPerson alloc] initWithFirst: @"Askara" andLastName: @"Barnes"];
    MHPerson *person4 = [[MHPerson alloc] initWithFirst: @"Billy" andLastName: @"Barnes"];
    MHPerson *person5 = [[MHPerson alloc] initWithFirst: @"Aaron" andLastName: @"Chung"];
    
    MHGenerator *testObject = [[MHGenerator alloc] init];
    
    NSArray *people = @[person1, person2, person3, person4, person5];
    NSArray *assignments = [testObject createAssignmentsForPeople: people];
    NSArray *givers = [self giversFromAssignments:assignments];
    STAssertEqualObjects(givers, people, nil);
    NSArray *recipients = [self recipientsFromAssignments:assignments];
    STAssertTrue([recipients containsObject: person1], nil);
    STAssertTrue([recipients containsObject: person2], nil);
    STAssertTrue([recipients containsObject: person3], nil);
    STAssertTrue([recipients containsObject: person4], nil);
    STAssertTrue([recipients containsObject: person5], nil);
    STAssertFalse([self assignmentsContainSamePerson: assignments], nil);
    STAssertFalse([self assignmentsContainTwoPeopleFromTheSameFamily: assignments], nil);
}

- (void)testWhenOnlyOnePersonExistsThenNilIsReturned {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
       
    MHGenerator *testObject = [[MHGenerator alloc] init];

    NSArray *people = @[person1];
    NSArray *assignments = [testObject createAssignmentsForPeople: people];
    
    STAssertNil(assignments, nil);
}

- (void)testWhenNoMatchesExistBecauseOfTooManyOfOneFamilyThenNilIsReturned {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
    MHPerson *person2 = [[MHPerson alloc] initWithFirst: @"Bob" andLastName: @"Arlington"];
    MHPerson *person3 = [[MHPerson alloc] initWithFirst: @"Charlie" andLastName: @"Arlington"];
    MHPerson *person4 = [[MHPerson alloc] initWithFirst: @"Alice" andLastName: @"Bones"];
    MHPerson *person5 = [[MHPerson alloc] initWithFirst: @"Betty" andLastName: @"Bones"];
    
    MHGenerator *testObject = [[MHGenerator alloc] init];
    
    NSArray *people = @[person1, person2, person3, person4, person5];
    NSArray *assignments = [testObject createAssignmentsForPeople: people];
    
    STAssertNil(assignments, nil);
}

- (void)testAllMatchesCanBeCreated {
    MHPerson *person1 = [[MHPerson alloc] initWithFirst: @"Adam" andLastName: @"Arlington"];
    MHPerson *person2 = [[MHPerson alloc] initWithFirst: @"Bob" andLastName: @"Arlington"];
    MHPerson *person3 = [[MHPerson alloc] initWithFirst: @"Askara" andLastName: @"Barnes"];
    MHPerson *person4 = [[MHPerson alloc] initWithFirst: @"Billy" andLastName: @"Barnes"];
    MHPerson *person5 = [[MHPerson alloc] initWithFirst: @"Aaron" andLastName: @"Chung"];
    
    MHGenerator *testObject = [[MHGenerator alloc] init];
    
    NSArray *people = @[person1, person2, person3, person4, person5];
    NSArray *expectedRecipients = @[person5, person3, person2, person1, person4];
    BOOL found = NO;
    int count = 0;
    while (count < 20000 && !found) {
        count++;
        NSArray *assignments = [testObject createAssignmentsForPeople: people];
        NSArray *recipients = [self recipientsFromAssignments:assignments];
        found = [recipients isEqualToArray:expectedRecipients];
    }
    STAssertTrue(found, nil);
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
