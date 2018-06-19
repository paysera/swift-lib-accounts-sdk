import Foundation
import Alamofire

public enum AccountsApiRequestRouter: URLRequestConvertible {
    
    // MARK: - GET
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String)
    case getPaymentCards(cardsFilter: PSGetPaymentCardsFilter)
    case getPaymentCardLimit(accountNumber: String)
    
    // MARK: - POST
    case createCard(PSCreatePaymentCard)
    
    // MARK: - PUT
    case activateCard(id: Int)
    case deactivateCard(id: Int)
    case setPaymentCardLimit(accountNumber: String, cardLimit: PSPaymentCardLimit?)
    case retrievePaymentCardPIN(cardId: Int, cvv: String)
    case cancelPaymentCard(cardId: Int)
    
    // MARK: - Declarations
    static var baseURLString = "https://accounts.paysera.com/public"
    
    private var method: HTTPMethod {
        switch self {
        case .getIbanInformation( _):
            return .get
          
        case .getBalance( _):
            return .get
        
        case .getPaymentCards( _):
            return .get
            
        case .getPaymentCardLimit( _):
            return .get
            
        case .createCard( _):
            return .post
            
        case .activateCard( _):
            return .put
            
        case .deactivateCard( _):
            return .put
            
        case .setPaymentCardLimit( _, _):
            return .put
            
        case .retrievePaymentCardPIN( _, _):
            return .put
            
        case .cancelPaymentCard( _):
            return .put
            
        }
    }
    
    private var path: String {
        switch self {
            
        case .getIbanInformation(let iban):
            return "/transfer/rest/v1/swift/\(iban)"
            
        case .getBalance(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/full-balance"
            
        case .getPaymentCards( _):
            return "/payment-card/v1/cards"
            
        case .getPaymentCardLimit(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/card-limit"
            
        case .createCard( _):
            return "/payment-card/v1/cards"
            
        case .activateCard(let id):
            return "/payment-card/v1/cards/\(String(id))/activate"
            
        case .deactivateCard(let id):
            return "/payment-card/v1/cards/\(String(id))/deactivate"
            
        case .setPaymentCardLimit(let accountNumber, _):
            return "/payment-card/v1/accounts/\(accountNumber)/card-limit"
            
        case .retrievePaymentCardPIN(let cardId, _):
            return "/payment-card/v1/cards/\(String(cardId))/pin"
            
        case .cancelPaymentCard(let id):
            return "/payment-card/v1/cards/\(String(id))/cancel"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
 
        case .getPaymentCards(let cardsFilter):
            return cardsFilter.toJSON()
            
        case .createCard(let psCard):
            return psCard.toJSON()
            
        case .setPaymentCardLimit(_, let cardLimit):
            return cardLimit?.toJSON()
            
        case .retrievePaymentCardPIN( _, let cvv):
            return ["cvv2" :cvv]
            
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
