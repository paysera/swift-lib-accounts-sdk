 import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

public class AccountsApiClient {
    private let sessionManager: SessionManager
    private let tokenRefresher: TokenRefresherProtocol?
    private let credentials: AccountsApiCredentials
    private var requestsQueue = [AccountsApiRequest]()
    
    public init(
        sessionManager: SessionManager,
        credentials: AccountsApiCredentials,
        tokenRefresher: TokenRefresherProtocol?
        ) {
        self.sessionManager = sessionManager
        self.tokenRefresher = tokenRefresher
        self.credentials = credentials
    }
    
    // MARK: - Paysera wallet information API
    public func getIbanInformation(iban: String) -> Promise<PSIbanInformation> {
        let request = createRequest(.getIbanInformation(iban: iban))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getBalance(accountNumber: String) -> Promise<PSBalanceInformation> {
        let request = createRequest(.getBalance(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    
    // MARK: - Payment cards API
    public func createCard(_ card: PSCard) -> Promise<PSCard> {
        
        let request = createRequest(.createCard(card))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func activateCard(_ id: Int) -> Promise<PSCard> {
        
        let request = createRequest(.activateCard(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }

    /// Get cards endpoint
    ///
    /// - Parameter cardsFilter: PSGetCardsFilter object, to fill request parameters. One of account_numbers, card_owner_id or account_owner_id must be filled
    /// - Returns: object PSMetadataAwareResponse with items array of PSCard
    public func getCards(cardsFilter: PSGetCardsFilter) -> Promise<PSMetadataAwareResponse<PSCard>> {
        
        let request = createRequest(.getCards(cardsFilter: cardsFilter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    private func makeRequest(apiRequest: AccountsApiRequest) {
        let lockQueue = DispatchQueue(label: String(describing: tokenRefresher), attributes: [])
        lockQueue.sync {
            if let tokenRefresher = tokenRefresher, tokenRefresher.isRefreshing() {
                requestsQueue.append(apiRequest)
            } else {
                sessionManager
                    .request(apiRequest.requestEndPoint)
                    .responseJSON { (response) in
                        let responseData = response.result.value
                        
                        guard let statusCode = response.response?.statusCode else {
                            let error = self.mapError(body: responseData)
                            apiRequest.pendingPromise.resolver.reject(error)
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            apiRequest.pendingPromise.resolver.fulfill(responseData as! [String: Any])
                        } else {
                            let error = self.mapError(body: responseData)
                            if statusCode == 401 {
                                guard let tokenRefresher = self.tokenRefresher else {
                                    apiRequest.pendingPromise.resolver.reject(error)
                                    return
                                }
                                lockQueue.sync {
                                    if self.credentials.hasRecentlyRefreshed() {
                                        self.makeRequest(apiRequest: apiRequest)
                                        return
                                    }
                                    
                                    self.requestsQueue.append(apiRequest)
                                    
                                    if !tokenRefresher.isRefreshing() {
                                        tokenRefresher
                                            .refreshToken()
                                            .done { result in
                                                self.resumeQueue()
                                            }.catch { error in
                                                self.cancelQueue(error: error)
                                        }
                                    }
                                }
                            } else {
                                apiRequest.pendingPromise.resolver.reject(error)
                            }
                        }
                }
            }
        }
    }
    
    private func resumeQueue() {
        for request in requestsQueue {
            makeRequest(apiRequest: request)
        }
        requestsQueue.removeAll()
    }
    
    private func cancelQueue(error: Error) {
        for requests in requestsQueue {
            requests.pendingPromise.resolver.reject(error)
        }
        requestsQueue.removeAll()
    }
    
    private func createPromiseWithArrayResult<T: Mappable>(body: Any) -> Promise<[T]> {
        guard let objects = Mapper<T>().mapArray(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(objects)
    }
    
    private func createPromise<T: Mappable>(body: Any) -> Promise<T> {
        guard let object = Mapper<T>().map(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(object)
    }
    
    private func mapError(body: Any?) -> PSAccountApiError {
        if let apiError = Mapper<PSAccountApiError>().map(JSONObject: body) {
            return apiError
        }
        
        return PSAccountApiError.unknown()
    }
    
    private func createRequest(_ endpoint: AccountsApiRequestRouter) -> AccountsApiRequest {
        return AccountsApiRequest(
            pendingPromise: Promise<Any>.pending(),
            requestEndPoint: endpoint
        )
    }
}
