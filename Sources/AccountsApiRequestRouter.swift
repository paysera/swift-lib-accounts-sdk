import Foundation
import Alamofire
import PayseraCommonSDK

public enum AccountsApiRequestRouter: URLRequestConvertible {
    case get(path: String, parameters: [String: Any]?)
    case post(path: String, parameters: [String: Any]?)
    case put(path: String, parameters: [String: Any]?)
    case putWithData(path: String, data: Data, contentType: String)
    case delete(path: String, parameters: [String: Any]?)
    
    // MARK: - GET
    case getLastUserQuestionnaire(userId: Int)
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String, showHistoricalCurrencies: Bool)
    case getPaymentCards(cardsFilter: PSGetPaymentCardsFilterRequest)
    case getPaymentCardDesigns(filter: PSPaymentCardDesignFilter)
    case getPaymentCardLimit(accountNumber: String)
    case getPaymentCardShippingAddress(accountNumber: String)
    case getPaymentCardDeliveryPrices(country: String)
    case getPaymentCardIssuePrice(filter: PSPaymentCardIssuePriceFilter)
    case getPaymentCardDeliveryDate(country: String, deliveryType: String)
    case getPaymentCardDeliveryCountries(filter: PSBaseFilter)
    case getCategorizedAccountNumbers(filter: PSGetCategorizedAccountNumbersFilterRequest)
    case getTransfer(id: String)
    case canUserOrderCard(userId: Int)
    case canUserFillQuestionnaire(userId: Int)
    case getAuthorizations(PSGetAuthorizationsFilterRequest)
    case getPaymentPaymentCardExpiringCardOrderRestriction(accountNumber: String)
    case getPaymentCardDeliveryPreference(accountNumber: String)
    case getAvailableCurrencies(filter: PSAvailableCurrencyFilter)
    case getPurposeCodes
    case getSigningLimits(userId: Int)
    
    
    // MARK: - POST
    case createCard(PSCreatePaymentCardRequest)
    case createAuthorization(PSCreateAuthorizationRequest)
    case createAccount(userId: Int)
    
    // MARK: - PUT
    case deactivateAccount(accountNumber: String)
    case activateAccount(accountNumber: String)
    case activateCard(id: Int)
    case enableCard(id: Int)
    case deactivateCard(id: Int)
    case setPaymentCardLimit(accountNumber: String, cardLimit: PSUpdatePaymentCardLimitRequest)
    case retrievePaymentCardPIN(id: Int, cvv: String)
    case cancelPaymentCard(id: Int)
    case setAccountDefaultDescription(accountNumber: String, description: String)
    case setAccountDescription(userId: Int, accountNumber: String, description: String)
    case updateAuthorization(id: String, createAuthorizationRequest: PSCreateAuthorizationRequest)
    case setPaymentCardDeliveryPreference(accountNumber: String, preference: PSPaymentCardDeliveryPreference)
    case validateAuthorization(accountNumber: String, userIds: [Int])
    
    // MARK: - Delete
    case deleteAuthorization(id: String)
    case deleteUserFromAuthorization(authorizationId: String, userId: String)
    
    // MARK: - Declarations
    static var baseURLString = "https://accounts.paysera.com/public"
    
    private var method: HTTPMethod {
        switch self {
        case .get,
             .getIbanInformation,
             .getLastUserQuestionnaire,
             .getBalance,
             .getPaymentCards,
             .getPaymentCardDesigns,
             .getPaymentCardLimit,
             .getPaymentCardShippingAddress,
             .getPaymentCardDeliveryPrices,
             .getPaymentCardIssuePrice,
             .getPaymentCardDeliveryDate,
             .getCategorizedAccountNumbers,
             .getTransfer,
             .canUserOrderCard,
             .canUserFillQuestionnaire,
             .getPaymentCardDeliveryCountries,
             .getAuthorizations,
             .getPaymentCardDeliveryPreference,
             .getPaymentPaymentCardExpiringCardOrderRestriction,
             .getAvailableCurrencies,
             .getPurposeCodes,
             .getSigningLimits:
            return .get

        case .post,
             .createCard,
             .createAccount,
             .createAuthorization:
            return .post
            
        case .put,
             .putWithData,
             .activateCard,
             .enableCard,
             .deactivateCard,
             .setPaymentCardLimit,
             .retrievePaymentCardPIN,
             .cancelPaymentCard,
             .deactivateAccount,
             .activateAccount,
             .setAccountDefaultDescription,
             .updateAuthorization,
             .setAccountDescription,
             .setPaymentCardDeliveryPreference,
             .validateAuthorization:
            return .put

        case .delete,
             .deleteAuthorization,
             .deleteUserFromAuthorization:
            return .delete
        }
    }
    
    private var path: String {
        switch self {
        case .get(let path, _),
             .post(let path, _),
             .put(let path, _),
             .putWithData(let path, _, _),
             .delete(let path, _):
            return path
            
        case .activateAccount(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/activate"
            
        case .deactivateAccount(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/deactivate"
            
        case .setAccountDefaultDescription(let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/descriptions"
            
        case .getLastUserQuestionnaire(let userId):
            return "/questionnaire/rest/v1/user/\(userId)/questionnaire"
            
        case .getIbanInformation(let iban):
            return "/transfer/rest/v1/bank-information/\(iban)"
            
        case .getTransfer(let id):
            return "/transfer/rest/v1/transfers/\(id)"
            
        case .getBalance(let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/full-balance"
            
        case .getPaymentCards:
            return "/issued-payment-card/v1/cards"
            
        case .getPaymentCardDesigns:
            return "/issued-payment-card/v1/card-designs"
            
        case .getPaymentCardDeliveryCountries:
            return "/issued-payment-card/v1/card-delivery-countries"
            
        case .getPaymentCardLimit(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .getPaymentCardShippingAddress(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/shipping-address"
            
        case .getPaymentCardDeliveryPreference(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-delivery-preference"
            
        case .getPaymentPaymentCardExpiringCardOrderRestriction(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/expiring-card-reorder-restriction"

        case .getPaymentCardDeliveryPrices(let country):
            return "/issued-payment-card/v1/card-delivery-prices/\(country)"
            
        case .getPaymentCardIssuePrice:
            return "/issued-payment-card/v1/card-account-issue-price"
            
        case .getPaymentCardDeliveryDate:
            return "/issued-payment-card/v1/card-delivery-date"
            
        case .getCategorizedAccountNumbers:
            return "/transfer/rest/v1/categorized-account-numbers"
            
        case .createCard:
            return "/issued-payment-card/v1/cards"
            
        case .activateCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/activate"
            
        case .enableCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/enable"
            
        case .deactivateCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/deactivate"
            
        case .setPaymentCardLimit(let accountNumber, _):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .retrievePaymentCardPIN(let id, _):
            return "/issued-payment-card/v1/cards/\(String(id))/pin"
            
        case .cancelPaymentCard(let id):
            return "/issued-payment-card/v1/cards/\(String(id))/cancel"
            
        case .createAccount(let userId):
            return "/account/rest/v1/users/\(String(userId))/accounts"
            
        case .setAccountDescription( _,let accountNumber, _):
            return "/account/rest/v1/accounts/\(accountNumber)/descriptions"
            
        case .canUserOrderCard:
            return "/client-allowance/rest/v1/client-allowances/can-order-card"
            
        case .canUserFillQuestionnaire:
            return "/client-allowance/rest/v1/client-allowances/can-fill-questionnaire"
            
        case .getAuthorizations:
            return "/permission/rest/v1/authorizations"
            
        case .createAuthorization:
            return "/permission/rest/v1/authorizations"
            
        case .deleteAuthorization(let id):
            return "/permission/rest/v1/authorizations/\(id)"
            
        case .updateAuthorization(let id, _):
            return "/permission/rest/v1/authorizations/\(id)"
            
        case .setPaymentCardDeliveryPreference(let accountNumber, _):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-delivery-preference"

        case .getAvailableCurrencies:
            return "/currency/rest/v1/available-currencies"
            
        case .getPurposeCodes:
            return "/transfer/rest/v1/purpose-codes"

        case .deleteUserFromAuthorization(let authorizationId, let userId):
            return "/permission/rest/v1/authorizations/\(authorizationId)/users/\(userId)"
        
        case .getSigningLimits(let userId):
            return "/permission/rest/v1/users/\(userId)/limits"
            
        case .validateAuthorization:
            return "/permission/rest/v1/authorizations/authorization-validation"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .get(_, let parameters),
             .post(_, let parameters),
             .put(_, let parameters),
             .delete(_, let parameters):
            return parameters
            
        case .getBalance( _, let showHistoricalCurrencies):
            return ["show_historical_currencies": showHistoricalCurrencies ? 1 : 0]
            
        case .getPaymentCardDeliveryDate(let country, let deliveryType):
            return ["country": country, "delivery_type": deliveryType]
        
        case .getPaymentCardDesigns(let filter):
            return filter.toJSON()

        case .getPaymentCardIssuePrice(let filter):
            return filter.toJSON()
            
        case .getPaymentCardDeliveryCountries(let filter):
            return filter.toJSON()
            
        case .getPaymentCards(let cardsFilter):
            return cardsFilter.toJSON()
            
        case .getCategorizedAccountNumbers(let filter):
            return filter.toJSON()
            
        case .createCard(let psCard):
            return psCard.toJSON()
            
        case .setPaymentCardLimit(_, let cardLimit):
            return cardLimit.toJSON()
            
        case .retrievePaymentCardPIN( _, let cvv):
            return ["cvv2" :cvv]
            
        case .setAccountDefaultDescription( _, let description):
            return ["description": description]
            
        case .setAccountDescription(let userId, _, let description):
            return ["body": ["description" : description], "query": ["user_id": userId]]
            
        case .canUserOrderCard(let userId):
            return ["user_id": userId]
            
        case .canUserFillQuestionnaire(let userId):
            return ["user_id": userId]
            
        case .getAuthorizations(let psGetAuthorizationsRequest):
            return psGetAuthorizationsRequest.toJSON()
            
        case .createAuthorization(let psCreateAuthorizationRequest):
            return psCreateAuthorizationRequest.toJSON()
        
        case .updateAuthorization( _, let psCreateAuthorizationRequest):
            return ["body": psCreateAuthorizationRequest.toJSON()]

        case .setPaymentCardDeliveryPreference(_, let preference):
            return preference.toJSON()
            
        case .getAvailableCurrencies(let filter):
            return filter.toJSON()
            
        case let .validateAuthorization(accountNumber, userIds):
            return [
                "account_number": accountNumber,
                "user_ids": userIds.compactMap(String.init)
            ]
        default:
            return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        let url = try! AccountsApiRequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .setAccountDescription(_, _, _):
            urlRequest = try CompositeEncoding.default.encode(urlRequest, with: parameters)
            
        case .updateAuthorization(_, _):
            urlRequest = try CompositeEncoding.default.encode(urlRequest, with: parameters)
            
        case (_) where method == .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        case (_) where method == .post:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
        case (_) where method == .put:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
