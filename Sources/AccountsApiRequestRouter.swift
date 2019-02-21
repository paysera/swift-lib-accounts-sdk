import Foundation
import Alamofire

public enum AccountsApiRequestRouter: URLRequestConvertible {
    
    // MARK: - GET
    case getLastUserQuestionnaire(userId: Int)
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String, showHistoricalCurrencies: Bool)
    case getPaymentCards(cardsFilter: PSGetPaymentCardsFilterRequest)
    case getPaymentCardLimit(accountNumber: String)
    case getPaymentCardShippingAddress(accountNumber: String)
    case getPaymentCardDeliveryPrices(country: String)
    case getPaymentCardIssuePrice(country: String, clientType: String, cardOwnerId: String)
    case getPaymentCardDeliveryDate(country: String, deliveryType: String)
    case getCategorizedAccountNumbers(filter: PSGetCategorizedAccountNumbersFilterRequest)
    case getTransfer(id: String)
    case setAccountDefaultDescription(accountNumber: String, description: String)
    
    
    // MARK: - POST
    case createCard(PSCreatePaymentCardRequest)
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
    
    // MARK: - Declarations
    static var baseURLString = "https://accounts.paysera.com/public"
    
    private var method: HTTPMethod {
        switch self {
        case .getIbanInformation( _),
             .getLastUserQuestionnaire( _),
             .getBalance( _, _),
             .getPaymentCards( _),
             .getPaymentCardLimit( _),
             .getPaymentCardShippingAddress( _),
             .getPaymentCardDeliveryPrices( _),
             .getPaymentCardIssuePrice( _, _, _),
             .getPaymentCardDeliveryDate( _, _),
             .getCategorizedAccountNumbers( _),
             .getTransfer( _):
            return .get
            
        case .createCard( _),
             .createAccount( _):
            return .post
            
        case .activateCard( _),
             .enableCard(_ ),
             .deactivateCard( _),
             .setPaymentCardLimit( _, _),
             .retrievePaymentCardPIN( _, _),
             .cancelPaymentCard( _),
             .deactivateAccount( _),
             .activateAccount( _),
             .setAccountDefaultDescription( _, _):
            return .put
        }
    }
    
    private var path: String {
        switch self {
        
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
            
        case .getPaymentCards( _):
            return "/issued-payment-card/v1/cards"
            
        case .getPaymentCardLimit(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .getPaymentCardShippingAddress(let accountNumber):
            return "/issued-payment-card/v1/accounts/\(accountNumber)/shipping-address"
            
        case .getPaymentCardDeliveryPrices(let country):
            return "/issued-payment-card/v1/card-delivery-prices/\(country)"
        
        case .getPaymentCardIssuePrice(let country, let clientType, let cardOwnerId):
            return "/issued-payment-card/v1/card-issue-price/\(country)/\(clientType)/\(cardOwnerId)"
            
        case .getPaymentCardDeliveryDate( _, _):
            return "/issued-payment-card/v1/card-delivery-date"
            
        case .getCategorizedAccountNumbers( _):
            return "/transfer/rest/v1/categorized-account-numbers"
            
        case .createCard( _):
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
            return "/public/account/rest/v1/users/\(String(userId))/accounts"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
            case .getBalance( _, let showHistoricalCurrencies):
                return ["show_historical_currencies": showHistoricalCurrencies ? 1 : 0]
 
            case .getPaymentCardDeliveryDate(let country, let deliveryType):
                return ["country": country, "delivery_type": deliveryType]
            
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
