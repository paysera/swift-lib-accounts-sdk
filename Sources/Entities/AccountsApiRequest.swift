import Foundation
import PromiseKit

class AccountsApiRequest {
    let requestEndPoint: AccountsApiRequestRouter
    let pendingPromise: (promise: Promise<Any>, resolver: Resolver<Any>)
    
    init(pendingPromise: (promise: Promise<Any>, resolver: Resolver<Any>), requestEndPoint: AccountsApiRequestRouter) {
        self.pendingPromise = pendingPromise
        self.requestEndPoint = requestEndPoint
    }   
}
