import Foundation
import Alamofire

public enum AccountsApiRequestRouter: URLRequestConvertible {
    
    // MARK: - GET
    case getIbanInformation(iban: String)
    case getBalance(accountNumber: String)
    case getPaymentCards(cardsFilter: PSGetPaymentCardsFilter)
    
    // MARK: - POST
    case createCard(PSCreatePaymentCard)
    
    // MARK: - PUT
    case activateCard(id: Int)
    
    
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
            
        case .createCard( _):
            return .post
            
        case .activateCard( _):
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
            
        case .createCard( _):
            return "/payment-card/v1/cards"
            
        case .activateCard(let id):
            return "/payment-card/v1/cards/\(String(id))/activate"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
 
        case .getPaymentCards(let cardsFilter):
            return cardsFilter.toJSON()
            
        case .createCard(let psCard):
            return psCard.toJSON()
            
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
