import Foundation
import PromiseKit

public protocol TokenRefresherProtocol {
    func refreshToken() -> Promise<Bool>
    func isRefreshing() -> Bool
}
