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



@end
