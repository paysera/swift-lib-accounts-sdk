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
        let session = Session(interceptor: interceptor)
    
        return AccountsApiClient(
            session: session,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
