import Foundation
import Alamofire
import PayseraCommonSDK

public class AccountsApiClientFactory {
    public static func createAccountsApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> AccountsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = PSRequestAdapter(credentials: credentials)
    
        return AccountsApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
