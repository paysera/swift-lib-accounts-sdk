import Foundation
import Alamofire

public class AuthenticationRequestAdapter: RequestAdapter {
    private let accountsApiCredentials: AccountsApiCredentials
    
    init(accountsApiCredentials: AccountsApiCredentials) {
        self.accountsApiCredentials = accountsApiCredentials
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue("Bearer " + (accountsApiCredentials.token?.string ?? ""), forHTTPHeaderField: "Authorization")

        
        return urlRequest
    }
}
