
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface httpRequests: NSObject

/*

+(void)loginWithFacebookID:(NSString*)facebookID
                 firstName:(NSString*)firstName
                  lastName:(NSString*)lastName
                   success:(void (^)(NSDictionary*))successHandler
                     error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;


+(void)getUserLeaderboarsWithSuccess:(void (^)(NSDictionary*))successHandler
                               error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getRestaurantWithCityId:(NSString*)orasID
              lastRestaurantID:(NSString*)ID
                       success:(void (^)(NSDictionary*))successHandler
                         error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getCitiesWithSuccess:(void (^)(NSArray*))successHandler
                      error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getOneRestaurantWithID:(NSString*)restaurantID
                    andUserID:(NSString*)userID
                      success:(void (^)(NSDictionary*))successHandler
                        error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;
+(void)getDetaliiVin:(NSString*) vinID
             success:(void (^)(NSDictionary*))successHandler
               error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;
*/

//POST creare user nou
+(void) createUserWithUsername:(NSString*)Username
                      password:(NSString*)password
                         email:(NSString*) emailAddress
                       success:(void (^)(id data))successHandler
                         error:(void (^)(AFHTTPRequestOperation* operation, NSError* error)) errorHandler;
//GET toti userii
+(void) getAllUserssuccess:(void (^)(id data))successHandler
                     error:(void (^)(AFHTTPRequestOperation* operation, NSError* error)) errorHandler;
//POST creare mesaj nou
+(void)createMessageWithUserID:(NSString*)UserID
                   messageText:(NSString *)messageText
                      latitude:(NSString *)latitude
                     longitude:(NSString*)longitude
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;

//GET ia toate mesajele
+(void)getAllMessagessuccess:(void (^)(id data))successHandler
                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;


@end
