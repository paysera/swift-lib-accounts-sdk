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
    
    /// Create a new payment card
    ///
    /// - Parameter card: PSCreatePaymentCard entity should be filled.
    /// - Returns: PSPaymentCard
    public func createPaymentCard(_ card: PSCreatePaymentCard) -> Promise<PSPaymentCard> {
        
        let request = createRequest(.createCard(card))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// Activate payment card
    ///
    /// - Parameter id: requested card id
    /// - Returns: PSPaymentCard
    public func activateCard(_ id: Int) -> Promise<PSPaymentCard> {
        
        let request = createRequest(.activateCard(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// deactivate payment card temporarily
    ///
    /// - Parameter cardId: required field
    /// - Returns: PSPaymentCard
    public func deactivatePaymentCard(cardId: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.cancelPaymentCard(cardId: cardId))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// retrieves payment card PIN
    ///
    /// - Parameters:
    ///   - cardId: required field
    ///   - cvv: required field
    /// - Returns: PSPaymentCardPIN
    public func retrievePaymentCardPIN(cardId: Int, cvv: String) -> Promise<PSPaymentCardPIN> {
        let request = createRequest(.retrievePaymentCardPIN(cardId: cardId, cvv: cvv))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// Get cards endpoint
    ///
    /// - Parameter cardsFilter: PSGetPaymentCardsFilter entity should be filled.
    /// - Returns: object PSMetadataAwareResponse with items array of PSCard
    public func getPaymentCards(cardsFilter: PSGetPaymentCardsFilter) -> Promise<PSMetadataAwareResponse<PSPaymentCard>> {
        
        let request = createRequest(.getPaymentCards(cardsFilter: cardsFilter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// set payment card spending amount limit
    ///
    /// - Parameters:
    ///   - accountNumber: required field
    ///   - cardLimit: optional field
    /// - Returns: PSPaymentCardLimit with optional values inside
    public func setPaymentCardLimit(accountNumber: String, cardLimit: PSPaymentCardLimit?) -> Promise<PSPaymentCardLimit> {
        let request = createRequest(.setPaymentCardLimit(accountNumber: accountNumber, cardLimit: cardLimit))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// get payment card amount limits
    ///
    /// - Parameter accountNumber: required field
    /// - Returns: PSPaymentCardLimit with optional values inside
    public func getPaymentCardLimit(accountNumber: String) -> Promise<PSPaymentCardLimit> {
        let request = createRequest(.getPaymentCardLimit(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    /// Cancels user card. It can not be restored later
    ///
    /// - Parameter cardId: required field
    /// - Returns: PSPaymentCard
    public func cancelPaymentCard(cardId: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.cancelPaymentCard(cardId: cardId))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    
    // MARK: - Private request methods
    
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
