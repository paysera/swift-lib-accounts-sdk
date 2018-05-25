import Foundation
import Alamofire

public class AuthenticationRequestAdapter: RequestAdapter {
    private let accountsApiCredentials: AccountsApiCredentials
    
    init(accountsApiCredentials: AccountsApiCredentials) {
        self.accountsApiCredentials = accountsApiCredentials
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let token = accountsApiCredentials.token {
            urlRequest.setValue("Bearer " + token.string, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}
