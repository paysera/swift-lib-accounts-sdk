import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        let token = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDE2MTAwMDE4NDU3NDQ6bSJdLCJwc3I6dSI6NDUxNzQ1LCJleHAiOjE1MjcyNDEwMzIsImlhdCI6MTUyNzIzNzQzMn0.4VAvxiZR2EeMkSBDzTGGY-slhkbLFT56fKMCffdh5YpYondmHcvZZGYwPNjzfLjbTYJTpxhT_gosLuOjROV3GAoqAyEaHPdKWa_1WkYlYOxkttCyh5uVySIAzGzaizzP-z05mvNlhGY2mnKvRmTUNSpglt2ildJvLW4F3GqCHqRg0rnZAnzjwKxid6uAxwCHUgI12bO0QEtvj40Sc8lnuS0bZBTz7RqP7hESNKm34WqJjGhxZ5Euvzx4sXHBn9SUtGcpg6RA7MfXv5tRr3aJcj4PMPK84VillwYlJB_N0CBRwwZDb-TLx1GdEo9p7j1Ibcv8b1idGVu44ucNe5PPH-2wcrpBogk_hvGWXRAM32-HL-p7s9IOaR9eI7tGmPxnv62twgeryau0-emP6uQfeEJxcI_aFKxvQkLTK-AoH8e6-iXJVfGR1NbyMoOTH66qt1cmoiU0czXq3SErDVy9yqe_hsON5cbEWyBucWD_ZPajxZ_1rWyDQS_wSuvlOTqNErsAjGwiloONz-El6cB9c_UBrLE_WUBxyaIXr5lfSu1PlvWJigXdLvVkc_PG8mNbr6XhCmJWo1oJzIzWQwf8WuQcAW0yO9klYiK018-9JmqXX5S2k8BKop60bbbHuJctNm1liQQi5JeNnZKwTpNOdk5-5JeLATktFLqJBGrMWLE"
        
        credentials.token = try! decode(jwt: token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetIbanInformation() {
        
        var ibanInformation: PSIbanInformation?
        let expectation = XCTestExpectation(description: "iban information should be not nil")
        
        accountsApiClient.getIbanInformation(iban: "LT383500010001845744").done { ibanInfo in
            ibanInformation = ibanInfo
            print("\n")
            print(ibanInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print(error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(ibanInformation)
    }
    
    func testCreatePaymentCard() {
        
        var cardsFilter = NSO
        var expectedCards: [PSPaymentCard]?
        
//        cardsFilter.limit = 25
//        cardsFilter.offset = 0
//        cardsFilter.orderBy = "createdAt"
//        cardsFilter.accountNumbers = ["EVP1610001845744"]
//        cardsFilter.orderDirection = "asc"
//        cardsFilter.statuses = ["ordered"]
 //       cardsFilter.cardOwnerId = "451745"
//        cardsFilter.accountOwnerId = "451745"
        
        let expectation = XCTestExpectation(description: "cards should be not nil")
        
        accountsApiClient.getCards(cardsFilter: cardsFilter)
        accountsApiClient.getCards(cardsFilter: cardsFilter).done { getCardsResponse in

            print("\n")
            print(getCardsResponse.toJSON())
            expectedCards = getCardsResponse.items
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print(error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(expectedCards)
    }
    
    func testGetCards() {
        
        var cardsFilter = PSGetCardsFilter()
        var expectedCards: [PSCard]?
        
        //        cardsFilter.limit = 25
        //        cardsFilter.offset = 0
        //        cardsFilter.orderBy = "createdAt"
        //        cardsFilter.accountNumbers = ["EVP1610001845744"]
        //        cardsFilter.orderDirection = "asc"
        //        cardsFilter.statuses = ["ordered"]
        //       cardsFilter.cardOwnerId = "451745"
        //        cardsFilter.accountOwnerId = "451745"
        
        let expectation = XCTestExpectation(description: "cards should be not nil")
        
        accountsApiClient.getCards(cardsFilter: cardsFilter)
        accountsApiClient.getCards(cardsFilter: cardsFilter).done { getCardsResponse in
            
            print("\n")
            print(getCardsResponse.toJSON())
            expectedCards = getCardsResponse.items
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print(error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(expectedCards)
    }
    
    func testGetBalanceInformation() {
        
        var balanceInformation: PSBalanceInformation?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.getBalance(accountNumber: "EVP1610001845744").done { balanceInfo in
            balanceInformation = balanceInfo
            
            print("\n")
            print(balanceInfo.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(balanceInformation)
    }
}
