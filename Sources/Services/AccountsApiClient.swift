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
    
    public func getTransfer(id: String) -> Promise<PSTransfer> {
        let request = createRequest(.getTransfer(id: id))
        makeRequest(apiRequest: request)

        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }

    public func activateAccount(accountNumber: String) -> Promise<PSAccount> {
        let request = createRequest(.activateAccount(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func deactivateAccount(accountNumber: String) -> Promise<PSAccount> {
        let request = createRequest(.deactivateAccount(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getLastUserQuestionnaire(userId: Int) -> Promise<PSQuestionnaire> {
        let request = createRequest(.getLastUserQuestionnaire(userId: userId))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getIbanInformation(iban: String) -> Promise<PSIbanInformation> {
        let request = createRequest(.getIbanInformation(iban: iban))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getBalance(
        accountNumber: String,
        showHistoricalCurrencies: Bool = false
    ) -> Promise<PSBalanceInformation> {
        let request = createRequest(.getBalance(
            accountNumber: accountNumber,
            showHistoricalCurrencies: showHistoricalCurrencies
        ))
        
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    // MARK: - Payment cards API
    public func createPaymentCard(_ card: PSCreatePaymentCardRequest) -> Promise<PSPaymentCard> {
        let request = createRequest(.createCard(card))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }

    public func activateCard(_ id: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.activateCard(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func enableCard(_ id: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.enableCard(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func deactivatePaymentCard(id: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.deactivateCard(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getCategorizedAccountNumbers(filter: PSGetCategorizedAccountNumbersFilterRequest) -> Promise<PSMetadataAwareResponse<PSCategorizedAccountNumbers>> {
        let request = createRequest(.getCategorizedAccountNumbers(filter: filter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func retrievePaymentCardPIN(id: Int, cvv: String) -> Promise<PSPaymentCardPIN> {
        let request = createRequest(.retrievePaymentCardPIN(id: id, cvv: cvv))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getPaymentCards(cardsFilter: PSGetPaymentCardsFilterRequest) -> Promise<PSMetadataAwareResponse<PSPaymentCard>> {
        let request = createRequest(.getPaymentCards(cardsFilter: cardsFilter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func setPaymentCardLimit(accountNumber: String, cardLimit: PSUpdatePaymentCardLimitRequest) -> Promise<PSPaymentCardLimit> {
        let request = createRequest(.setPaymentCardLimit(accountNumber: accountNumber, cardLimit: cardLimit))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getPaymentCardLimit(accountNumber: String) -> Promise<PSPaymentCardLimit> {
        let request = createRequest(.getPaymentCardLimit(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getPaymentCardShippingAddress(accountNumber: String) -> Promise<PSPaymentCardShippingAddress> {
        let request = createRequest(.getPaymentCardShippingAddress(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getPaymentCardDeliveryPrices(country: String) -> Promise<[PSPaymentCardDeliveryPrice]> {
        let request = createRequest(.getPaymentCardDeliveryPrices(country: country))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromiseWithArrayResult)
    }
    
    public func getPaymentCardIssuePrice(country: String, clientType: String, cardOwnerId: String) -> Promise<PSPaymentCardIssuePrice> {
        let request = createRequest(.getPaymentCardIssuePrice(country: country, clientType: clientType, cardOwnerId: cardOwnerId))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getPaymentCardDeliveryDate(country: String, deliveryType: String) -> Promise<PSPaymentCardDeliveryDate> {
        let request = createRequest(.getPaymentCardDeliveryDate(country: country, deliveryType: deliveryType))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func cancelPaymentCard(id: Int) -> Promise<PSPaymentCard> {
        let request = createRequest(.cancelPaymentCard(id: id))
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
                            apiRequest.pendingPromise.resolver.fulfill(responseData)
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
