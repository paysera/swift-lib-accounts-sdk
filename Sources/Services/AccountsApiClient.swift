import Foundation
import Alamofire
import ObjectMapper
import PromiseKit
import PayseraCommonSDK

public class AccountsApiClient: PSBaseApiClient {
    public func get(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        return doRequest(requestRouter: AccountsApiRequestRouter.get(path: path, parameters: parameters))
    }
    
    public func post(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        return doRequest(requestRouter: AccountsApiRequestRouter.post(path: path, parameters: parameters))
    }
    
    public func put(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        return doRequest(requestRouter: AccountsApiRequestRouter.put(path: path, parameters: parameters))
    }
    
    public func put(path: String, data: Data, contentType: String) -> Promise<Any> {
        return doRequest(requestRouter: AccountsApiRequestRouter.putWithData(path: path, data: data, contentType: contentType))
    }
    
    public func delete(path: String, parameters: [String: Any]? = nil) -> Promise<Any> {
        return doRequest(requestRouter: AccountsApiRequestRouter.delete(path: path, parameters: parameters))
    }
    
    public func getTransfer(id: String) -> Promise<PSTransfer> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getTransfer(id: id))
    }

    public func setDefaultAccountDescription(accountNumber: String, description: String) -> Promise<Void> {
        return doRequest(requestRouter: AccountsApiRequestRouter.setAccountDefaultDescription(accountNumber: accountNumber, description: description))
    }
    
    public func setAccountDescription(userId: Int, accountNumber: String, description: String) -> Promise<Void> {
        return doRequest(requestRouter: AccountsApiRequestRouter.setAccountDescription(userId: userId, accountNumber: accountNumber, description: description))
    }

    public func activateAccount(accountNumber: String) -> Promise<PSAccount> {
        return doRequest(requestRouter: AccountsApiRequestRouter.activateAccount(accountNumber: accountNumber))
    }
    
    public func deactivateAccount(accountNumber: String) -> Promise<PSAccount> {
        return doRequest(requestRouter: AccountsApiRequestRouter.deactivateAccount(accountNumber: accountNumber))
    }
    
    public func getLastUserQuestionnaire(userId: Int) -> Promise<PSQuestionnaire> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getLastUserQuestionnaire(userId: userId))
    }
    
    public func getIbanInformation(iban: String) -> Promise<PSIbanInformation> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getIbanInformation(iban: iban))
    }
    
    public func getBalance(
        accountNumber: String,
        showHistoricalCurrencies: Bool = false
    ) -> Promise<PSBalanceInformation> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getBalance(
            accountNumber: accountNumber,
            showHistoricalCurrencies: showHistoricalCurrencies
        ))
    }
    
    public func createAccount(userId: Int) -> Promise<PSAccount> {
        return doRequest(requestRouter: AccountsApiRequestRouter.createAccount(userId: userId))
    }
    
    public func canUserOrderCard(userId: Int) -> Promise<PSClientAllowance> {
        return doRequest(requestRouter: AccountsApiRequestRouter.canUserOrderCard(userId: userId))
    }
    
    public func canUserFillQuestionnaire(userId: Int) -> Promise<PSClientAllowance> {
        return doRequest(requestRouter: AccountsApiRequestRouter.canUserFillQuestionnaire(userId: userId))
    }
    
    public func getAvailableCurrencies(filter: PSAvailableCurrencyFilter) -> Promise<PSMetadataAwareResponse<PSAvailableCurrency>> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getAvailableCurrencies(filter: filter))
    }
    
    // MARK: - Payment cards API
    public func createPaymentCard(_ card: PSCreatePaymentCardRequest) -> Promise<PSPaymentCard> {
        return doRequest(requestRouter: AccountsApiRequestRouter.createCard(card))
    }

    public func activateCard(_ id: Int) -> Promise<PSPaymentCard> {
        return doRequest(requestRouter: AccountsApiRequestRouter.activateCard(id: id))
    }
    
    public func enableCard(_ id: Int) -> Promise<PSPaymentCard> {
        return doRequest(requestRouter: AccountsApiRequestRouter.enableCard(id: id))
    }
    
    public func deactivatePaymentCard(id: Int) -> Promise<PSPaymentCard> {
        return doRequest(requestRouter: AccountsApiRequestRouter.deactivateCard(id: id))
    }
    
    public func getCategorizedAccountNumbers(filter: PSGetCategorizedAccountNumbersFilterRequest) -> Promise<PSMetadataAwareResponse<PSCategorizedAccountNumbers>> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getCategorizedAccountNumbers(filter: filter))
    }
    
    public func retrievePaymentCardPIN(id: Int, cvv: String) -> Promise<PSPaymentCardPIN> {
        return doRequest(requestRouter: AccountsApiRequestRouter.retrievePaymentCardPIN(id: id, cvv: cvv))
    }
    
    public func getPaymentCardDeliveryCountries(filter: PSBaseFilter) -> Promise<PSPaymentCardDeliveryCountries> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryCountries(filter: filter))
    }
        
    public func getPaymentCards(cardsFilter: PSGetPaymentCardsFilterRequest) -> Promise<PSMetadataAwareResponse<PSPaymentCard>> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCards(cardsFilter: cardsFilter))
    }
    
    public func setPaymentCardLimit(accountNumber: String, cardLimit: PSUpdatePaymentCardLimitRequest) -> Promise<PSPaymentCardLimit> {
        return doRequest(requestRouter: AccountsApiRequestRouter.setPaymentCardLimit(accountNumber: accountNumber, cardLimit: cardLimit))
    }
    
    public func getPaymentCardLimit(accountNumber: String) -> Promise<PSPaymentCardLimit> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardLimit(accountNumber: accountNumber))
    }
    
    public func getPaymentCardDesigns(filter: PSPaymentCardDesignFilter) -> Promise<PSMetadataAwareResponse<PSPaymentCardDesign>> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDesigns(filter: filter))
    }
    
    public func getPaymentCardShippingAddress(accountNumber: String) -> Promise<PSPaymentCardShippingAddress> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardShippingAddress(accountNumber: accountNumber))
    }
    
    public func getPaymentCardDeliveryPrices(country: String) -> Promise<[PSPaymentCardDeliveryPrice]> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryPrices(country: country))
    }

    public func getPaymentCardIssuePrice(filter: PSPaymentCardIssuePriceFilter) -> Promise<PSPaymentCardIssuePrice> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardIssuePrice(filter: filter))
    }
    
    public func getPaymentCardDeliveryDate(country: String, deliveryType: String) -> Promise<PSPaymentCardDeliveryDate> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryDate(country: country, deliveryType: deliveryType))
    }
    
    public func getPaymentPaymentCardExpiringCardOrderRestriction(accountNumber: String) -> Promise<PSPaymentCardExpiringCardOrderRestriction> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentPaymentCardExpiringCardOrderRestriction(accountNumber: accountNumber))
    }
    
    public func cancelPaymentCard(id: Int) -> Promise<PSPaymentCard> {
        return doRequest(requestRouter: AccountsApiRequestRouter.cancelPaymentCard(id: id))
    }
    
    public func getPaymentCardDeliveryPreference(accountNumber: String) -> Promise<PSPaymentCardDeliveryPreference> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPaymentCardDeliveryPreference(accountNumber: accountNumber))
    }
    
    public func setPaymentCardDeliveryPreference(accountNumber: String, preference: PSPaymentCardDeliveryPreference) -> Promise<PSPaymentCardDeliveryPreference> {
        return doRequest(requestRouter: AccountsApiRequestRouter.setPaymentCardDeliveryPreference(accountNumber: accountNumber, preference: preference))
    }
    
    // MARK: - Authorizations API
    public func getAuthorizations(filter: PSGetAuthorizationsFilterRequest) -> Promise<PSMetadataAwareResponse<PSAuthorization>> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getAuthorizations(filter))
    }
    
    public func deleteAuthorization(id: String) -> Promise<Void> {
        return doRequest(requestRouter: AccountsApiRequestRouter.deleteAuthorization(id: id))
    }
    
    public func createAuthorization(authorization: PSCreateAuthorizationRequest) -> Promise<PSAuthorization> {
        return doRequest(requestRouter: AccountsApiRequestRouter.createAuthorization(authorization))
    }
    
    public func updateAuthorization(id: String, authorization: PSCreateAuthorizationRequest) -> Promise<PSAuthorization> {
        return doRequest(requestRouter: AccountsApiRequestRouter.updateAuthorization(id: id, createAuthorizationRequest: authorization))
    }
    
    public func getPurposeCodes() -> Promise<PSPurposeCodeCollection> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getPurposeCodes)
    }
    
    public func deleteUserFromAuthorization(authorizationId: String, userId: String) -> Promise<Void> {
        return doRequest(requestRouter: AccountsApiRequestRouter.deleteUserFromAuthorization(authorizationId: authorizationId, userId: userId))
    }
    
    public func getSigningLimits(userId: Int) -> Promise<PSAuthorizationUserLimits> {
        return doRequest(requestRouter: AccountsApiRequestRouter.getSigningLimits(userId: userId))
    }
    
    public func validateAuthorization(accountNumber: String, userIds: [Int]) -> Promise<Void> {
        return doRequest(requestRouter: AccountsApiRequestRouter.validateAuthorization(accountNumber: accountNumber, userIds: userIds))
    }
}
