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

public final class Twitter {
  public typealias OAuthToken = String
  public typealias OAuthTokenSecret = String
  public typealias UserId = String
  public typealias ScreenName = String
  
  public enum CustomError: Error {
    case unknown(error: Error?)
    case notGranted
    case hasNoAccounts
    case reverseOAuthTokenRequestFailed(error: Error?)
    case reverseAuthAccessTokenFailed(error: Error?)
    case verifyCredentialsWithUserFailed(error: Error?)
    case oAuthTokenIsEmpty
    case oAuthTokenSecretIsEmpty
    case userIdIsEmpty
    case screenNameIsEmpty
  }
  
  fileprivate let consumerKey: String
  fileprivate let consumerSecret: String
  
  public init(consumerKey: String, consumerSecret: String) {
    self.consumerKey = consumerKey
    self.consumerSecret = consumerSecret
  }
  
  public func fetchAllAccounts(_ success: @escaping ([ACAccount]) -> Void, failure: @escaping (CustomError) -> Void) {
    let store = ACAccountStore()
    let accountType = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
    
    store.requestAccessToAccounts(with: accountType, options: nil,
      completion: { (granted, error) in
        guard granted else {
          failure(CustomError.notGranted)
          return
        }
        
        if let error = error {
          failure(CustomError.unknown(error: error as NSError))
          return
        }
        
        guard let accounts = store.accounts(with: accountType) as? [ACAccount] , accounts.count > 0 else {
          failure(CustomError.hasNoAccounts)
          return
        }
        
        success(accounts)
      }
    )
  }
  
  public func reverseAuth(_ account: ACAccount, success: @escaping (OAuthToken, OAuthTokenSecret, UserId, ScreenName) -> Void, failure: @escaping (CustomError) -> Void) {
    let api = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret)
    api?.postReverseOAuthTokenRequest(
      { (authenticationHeader) in
        guard let osApi = STTwitterAPI.twitterAPIOS(with: account, delegate: nil) else {
          failure(CustomError.unknown(error: nil))

          return
        }
        
        osApi.verifyCredentials(
          userSuccessBlock: { _ in
            osApi.postReverseAuthAccessToken(withAuthenticationHeader: authenticationHeader,
              successBlock: { (oAuthToken, oAuthTokenSecret, userId, screenName) -> Void in
                
                // https://github.com/nst/STTwitter/commit/924e5a77f783a17d176de63fd8eca034f942c025
                guard let oAuthToken = oAuthToken, !oAuthToken.isEmpty else {
                  failure(CustomError.oAuthTokenIsEmpty)
                  return
                }
                
                guard let oAuthTokenSecret = oAuthTokenSecret, !oAuthTokenSecret.isEmpty else {
                  failure(CustomError.oAuthTokenSecretIsEmpty)
                  return
                }
                
                guard let userId = userId, !userId.isEmpty else {
                  failure(CustomError.userIdIsEmpty)
                  return
                }
                
                guard let screenName = screenName, !screenName.isEmpty else {
                  failure(CustomError.screenNameIsEmpty)
                  return
                }
                
                success(oAuthToken, oAuthTokenSecret, userId, screenName)
              },
              errorBlock: { error in
                failure(CustomError.reverseAuthAccessTokenFailed(error: error))
              }
            )
          },
          errorBlock: { error in
            failure(CustomError.verifyCredentialsWithUserFailed(error: error))
          }
        )
      },
      errorBlock: { (error) in
        failure(CustomError.reverseOAuthTokenRequestFailed(error: error))
      }
    )
  }
  
  public func renewCredentials(_ account: ACAccount, completion: ACAccountStoreCredentialRenewalHandler? = nil) {
    let store = ACAccountStore()
    store.renewCredentials(for: account, completion: completion)
  }
}
