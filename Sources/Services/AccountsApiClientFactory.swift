import Foundation
import Alamofire
import PayseraCommonSDK

public class AccountsApiClientFactory {
    public static func createAccountsApiClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> AccountsApiClient {
        let interceptor = PSRequestAdapter(credentials: credentials)
        let trustedSession = PSTrustedSession(
            interceptor: interceptor,
            hosts: ["accounts.paysera.com"]
        )
    
        return AccountsApiClient(
            session: trustedSession,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
