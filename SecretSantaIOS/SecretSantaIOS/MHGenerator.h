#import <Foundation/Foundation.h>

@interface MHGenerator : NSObject

/*
 * Create an array of Assignment objects for the Person objects given.  The assignments should always include both a giver and receiver, 
 * and should be returned in alphabetical order by giver's full name.  Everyone should be used as a giver exactly once.  Everyone should
 * be used as a receiver exactly once.  No person from the same family (defined by having the same last name) should be assigned to each
 * other.  The assignments should be as random as possible such that they fulfill all of these conditions.  If these conditions cannot
 * be met, then nil should be returned instead of an array.
 */
- (NSArray *) createAssignmentsForPeople: (NSArray *) people;
 
@end
