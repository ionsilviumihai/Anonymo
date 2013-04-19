

#import "httpRequests.h"
#import "AFHTTPClient.h"


@implementation httpRequests


//private methods

NSString *serverUrl = @"http://89.45.249.251/Anonimo"; //base url

+(void)sendPostRequest:(NSString *)relativeUrl
                  data:(NSDictionary *)dict
               success:(void (^)(id))successHandler
                 error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler
{
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
  
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:relativeUrl
                                                      parameters:dict];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^internalSuccessHandler)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation* operation, id responseObject) {
        
        NSError *error;
        NSLog(@"%@: %@", relativeUrl, [operation responseString]);
        NSData *data = [[operation responseString] dataUsingEncoding:NSUTF8StringEncoding];
        if(data)
        {
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        successHandler(responseObj);
        }
        else
        {
            NSLog(@"///////%d", [(NSHTTPURLResponse*)responseObject statusCode]);
            successHandler(nil);

            
        }
    };
    
    [operation setCompletionBlockWithSuccess:internalSuccessHandler failure:errorHandler];
    
    [operation start];
}



+(void)sendGetRequest:(NSString*)relativeUrl
                 data:(NSDictionary *)data
              success:(void (^)(id))successHandler
                error:(void (^)(AFHTTPRequestOperation*, NSError*))errorHandler
{
    
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:relativeUrl parameters:data];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^internalSuccessHandler)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation* operation, id responseObject) {
        NSError *error;
        //NSLog(@"%@", [operation responseString]);
        NSData *data = [[operation responseString] dataUsingEncoding:NSUTF8StringEncoding];
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        successHandler(responseObj);
    };
    
    [operation setCompletionBlockWithSuccess:internalSuccessHandler failure:errorHandler];
    
    [operation start];

}
/*
//pana aici nu modific :D
//public methods
+(void)loginWithFacebookID:(NSString *)facebookID  //trikmite la server id fn si ln 
                 firstName:(NSString *)firstName
                  lastName:(NSString *)lastName
                   success:(void (^)(NSDictionary *))successHandler 
                     error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    ///folosesc post daca fac modificari pe server
    [self sendPostRequest:@"fblogin" //concatenare la base url / se cheama URI
                       data:[NSDictionary dictionaryWithObjectsAndKeys:
                             facebookID, @"facebook_id", //nume parametrii de pe server
                             firstName,@"prenume",
                             lastName,@"nume",
                             nil]
                    success:^(NSDictionary *data) //data primeste de pe server
     {
         successHandler(data);
     }
     
     error:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}

+(void)getUserLeaderboarsWithSuccess:(void (^)(NSDictionary *))successHandler
                               error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    [self sendGetRequest:@"getusertop"
                    data:nil
                 success:^(NSDictionary *data)
                    {
                        successHandler(data);
                    }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                        errorHandler(operation,error);
                    }];
}

+(void)getRestaurantWithCityId:(NSString *)orasID
              lastRestaurantID:(NSString *)ID
                       success:(void (^)(NSDictionary *))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    if (ID)
    {
        [data setValue:ID forKey:@"lastId"];
    }
    
    [data setValue:orasID forKey:@"idOras"];
    [data setValue:@"10"
            forKey:@"nrRestaurant"];

    
    [self sendPostRequest:@"getRestaurant"
                     data:data
                 success:^(NSDictionary *data)
                    {
                     successHandler(data);
                    }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                       errorHandler(operation,error);

                   }];
}

+(void)getCitiesWithSuccess:(void (^)(NSArray*))successHandler
                      error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    [self sendGetRequest:@"getorase"
                    data:nil
                 success:^(NSArray *data)
     {
         successHandler(data);
     }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
     }];
    
}

+(void)getOneRestaurantWithID:(NSString *)restaurantID
                    andUserID:(NSString *)userID
                      success:(void (^)(NSDictionary *))successHandler
                        error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    [data setValue:restaurantID forKey:@"restaurant_id"];
    [data setValue:userID forKey:@"user_id"];
    
    
    [self sendPostRequest:@"getOneRestaurant"
                     data:data
                  success:^(NSDictionary *data)
     {
         successHandler(data);
     }
                    error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
         
     }];
    
    
}

+(void)getDetaliiVin:(NSString *)vinID
             success:(void (^)(NSDictionary *))successHandler
               error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    [data setValue:vinID forKey:@"id"];
    [data setValue:@"2" forKey:@"restaurant_id"];

    
    
    [self sendPostRequest:@"getDetaliiVin"
                     data:data
                  success:^(NSDictionary *data) 
     {
         successHandler(data);
     }
                    error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
         
     }];

}
*/

//POST creare user
+(void)createUserWithUsername:(NSString *)Username
                     password:(NSString *)password
                        email:(NSString *)emailAddress
                      success:(void (^)(id))successHandler
                        error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary *dataDict=[[NSMutableDictionary alloc]init];
    
    [dataDict setValue:Username forKey:@"name"];
    [dataDict setValue:password forKey:@"password"];
    [dataDict setValue:emailAddress forKey:@"email"];
    
    
    [self sendPostRequest:@"users" //concatenare la base url / se cheama URI
                     data:dataDict
                  success:^(NSDictionary *data) //data primeste de pe server
     {
         successHandler(data);
     }
     
                    error:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
}

//POST creare mesaj
+(void)createMessageWithUserID:(NSString*)UserID
                   messageText:(NSString *)messageText
                      latitude:(NSString *)latitude
                     longitude:(NSString *)longitude
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    [dataDict setValue:date forKey:@"date"];
    [dataDict setValue:latitude forKey:@"latitude"];
    [dataDict setValue:longitude forKey:@"longitude"];
    [dataDict setValue:messageText forKey:@"text"];
    [dataDict setValue:UserID forKey:@"userId"];
    
    [self sendPostRequest:@"messages"
                     data:dataDict
                  success:^(NSDictionary *data)
    {
        successHandler(data);
    }
                    error:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
}

//GET ia toti userii
+(void)getAllUserssuccess:(void (^)(id data))successHandler
                    error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler
{
    [self sendGetRequest:@"users" data:nil success:^(id data) {
        successHandler(data);
        
    } error:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

//GET ia toate mesajele
+(void)getAllMessagessuccess:(void (^)(id data))successHandler
                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler
{
    [self sendGetRequest:@"messages" data:nil success:^(id data) {
        successHandler(data);
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
