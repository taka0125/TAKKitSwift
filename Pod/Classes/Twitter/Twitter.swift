//
//  Twitter.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import Accounts
import STTwitter

final public class Twitter {
  public typealias OAuthToken = String
  public typealias OAuthTokenSecret = String
  public typealias UserId = String
  public typealias ScreenName = String
  
  public enum Error: ErrorType {
    case Unknown(error: NSError)
    case NotGranted
    case HasNoAccounts
    case ReverseOAuthTokenRequestFailed(error: NSError)
    case ReverseAuthAccessTokenFailed(error: NSError)
    case VerifyCredentialsWithUserFailed(error: NSError)
    case OAuthTokenIsEmpty
    case OAuthTokenSecretIsEmpty
  }
  
  private let consumerKey: String
  private let consumerSecret: String
  
  public init(consumerKey: String, consumerSecret: String) {
    self.consumerKey = consumerKey
    self.consumerSecret = consumerSecret
  }
  
  public func fetchAllAccounts(success: [ACAccount] -> Void, failure: Error -> Void) {
    let store = ACAccountStore()
    let accountType = store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    store.requestAccessToAccountsWithType(accountType, options: nil,
      completion: { (granted, error) in
        guard granted else {
          failure(Error.NotGranted)
          return
        }
        
        if let error = error {
          failure(Error.Unknown(error: error))
          return
        }
        
        guard let accounts = store.accountsWithAccountType(accountType) as? [ACAccount] where accounts.count > 0 else {
          failure(Error.HasNoAccounts)
          return
        }
        
        success(accounts)
      }
    )
  }
  
  public func reverseAuth(account: ACAccount, success: (OAuthToken, OAuthTokenSecret, UserId, ScreenName) -> Void, failure: Error -> Void) {
    let api = STTwitterAPI(OAuthConsumerKey: consumerKey, consumerSecret: consumerSecret)
    api.postReverseOAuthTokenRequest(
      { (authenticationHeader) in
        let osApi = STTwitterAPI.twitterAPIOSWithAccount(account)
        osApi.verifyCredentialsWithUserSuccessBlock(
          { (result, error) in
            api.postReverseAuthAccessTokenWithAuthenticationHeader(authenticationHeader,
              successBlock: { (oAuthToken, oAuthTokenSecret, userId, screenName) -> Void in
                
                // https://github.com/nst/STTwitter/commit/924e5a77f783a17d176de63fd8eca034f942c025
                guard let oAuthToken = oAuthToken where !oAuthToken.isEmpty else {
                  failure(Error.OAuthTokenIsEmpty)
                  return
                }
                
                guard let oAuthTokenSecret = oAuthTokenSecret where !oAuthTokenSecret.isEmpty else {
                  failure(Error.OAuthTokenSecretIsEmpty)
                  return
                }
                
                success(oAuthToken, oAuthTokenSecret, userId, screenName)
              },
              errorBlock: { error in
                failure(Error.ReverseAuthAccessTokenFailed(error: error))
              }
            )
          },
          errorBlock: { error in
            failure(Error.VerifyCredentialsWithUserFailed(error: error))
          }
        )
      },
      errorBlock: { (error) in
        failure(Error.ReverseOAuthTokenRequestFailed(error: error))
      }
    )
  }
  
  public func renewCredentials(account: ACAccount, completion: ACAccountStoreCredentialRenewalHandler? = nil) {
    let store = ACAccountStore()
    store.renewCredentialsForAccount(account, completion: completion)
  }
}
