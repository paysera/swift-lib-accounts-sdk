import Foundation
import Alamofire

public enum AccountsApiRequestRouter: URLRequestConvertible {
    static var baseURLString = "https://accounts.paysera.com/public"
    
    // GET
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String)
    case getCards(cardsFilter: PSGetPaymentCardsFilter)
    
    // POST
    case createCard(PSRequestPaymentCard)
    
    // PUT
    case activateCard(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getIbanInformation( _):
            return .get
          
        case .getBalance( _):
            return .get
        
        case .getCards( _):
            return .get
            
        case .createCard( _):
            return .post
            
        case .activateCard( _):
            return .put
        }
    }
    
    var path: String {
        switch self {
            
        case .getIbanInformation(let iban):
            return "/transfer/rest/v1/swift/\(iban)"
            
        case .getBalance(let accountNumber):
            return "/account/rest/v1/accounts/\(accountNumber)/full-balance"
            
        case .getCards( _):
            return "/payment-card/v1/cards"
            
        case .createCard( _):
            return "/payment-card/v1/cards"
            
        case .activateCard(let id):
            return "/payment-card/v1/cards/\(String(id))/activate"
        }
    }
    
    var parameters: Parameters? {
        switch self {
 
        case .getCards(let cardsFilter):
            return cardsFilter.toJSON()
            
        case .createCard(let psCard):
            return psCard.toJSON()
            
        default:
            return nil
        }
    }
    
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
