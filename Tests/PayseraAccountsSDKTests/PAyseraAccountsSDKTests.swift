import Foundation
import XCTest
import PayseraAccountsSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class AccountsSDKTests: XCTestCase {
    private var accountsApiClient: AccountsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.accountsApiClient = createAccountsApiClient()
    }
    
    func createAccountsApiClient() -> AccountsApiClient {
        let credentials = AccountsApiCredentials()
        let token =  "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDI4MTAwMDEyNDg2Mzc6bSIsImE6RVZQMTYxMDAwMTg0NTc0NDptIiwiYTpFVlA4NjEwMDAxNjcwMjM5Om0iLCJhOkVWUDkwMTAwMDE2NTAxMzY6bSJdLCJwc3I6dSI6NDUxNzQ1LCJleHAiOjE1MzI2ODc5MTgsImlhdCI6MTUzMjY4NDMxOH0.foUJj-A5sCTKHnrJb_RGEd8QfXqRf74SsOzn_ZgFb7VSGyr_VvU-tjX98pfeuR2JbuRJGVQpFXoIGjyY-9sOajRjQ4Ln31DG5e5fukCNrrv7Mb2L1lexWN0j3s3-l5mdaF2-9lc7BHar6tPR5YRiLx-929V9GUNZ47FH-G1mkTf8iMjRTc3gGtJRRrYbgiGbgobxqVU16rK50s1jNQhni8Jwz5kbUhfU0-Wz8HtF-CkTWHljn3By037nSt6Q2hY7vVx4kyNlsIIh8VkJGmAxnicBKPcJ_c4uS3Vb6E_ugKcXk_SIROy7GHifoitmkc7ERJ4hj4CbRt2rJbMX0pS93tRGbu7PwtxMaFLcBmZ5QW6lIBbp9oV-_vVenvBPRv5m1F8fTlnIOCum17iPZSGAyHBEzU-hStpwflzlwXvRKUCGfcyaDZdmh80zwQUx5PP_Mr7tUMSiJ2c2JiWEdPN-Dw6h_DVJSezj-IJ7eFHaFOf9pXVidUwbgSmeY-qsK39szad5OjYGTwbWvKg2lBKg-SljRCEI4K_hc1wIcQ-HSf7TqKvShDaYO5cuuC28sBMFHiPSnM6mR--MVr3cTk2tHnCkQm1eMtMZPv5fxq65nxv_2pKvARhLWhkrQf4DQM-ojx_EhLAoMoo76Veq5_7WXvuvwiwybH33Y1dmJ2qimjQ"
        
        credentials.token = try! decode(jwt: token)
        
        return AccountsApiClientFactory.createAccountsApiClient(credentials: credentials)
    }
    
    func testGetIbanInformation() {
        
        var ibanInformation: PSIbanInformation?
        let expectation = XCTestExpectation(description: "iban information should be not nil")
        
        let aa = PSCreatePaymentCardRequest(map: Map(mappingType: .toJSON, JSON: [:]))

        
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
        
        var expectedCard: PSPaymentCard?
    
        let createPaymentCard = PSCreatePaymentCardRequest(cardOwnerId: 1001,
                                                    shippingAddress: PSPaymentCardShippingAddress.init(postalCode: "9999999999", address: "test", city: "Kaunas", country: "Lithuania"),
                                                    deliveryType: "registered_post", accountOwnerId: 1001,
                                                    chargeInfo: PSChargeInfo.init(accountNumber: "EVP1610001845744"))

        let expectation = XCTestExpectation(description: "cards should be not nil")

        accountsApiClient.createPaymentCard(createPaymentCard).done { createCardResponse in

            print("\n")
            print(createCardResponse.toJSON())
            expectedCard = createCardResponse
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }

        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(expectedCard)
    }
    
    func testGetCards() {
        
        let cardsFilter = PSGetPaymentCardsFilterRequest(accountOwnerId: "451745")
        var expectedCards: [PSPaymentCard]?
        
        let expectation = XCTestExpectation(description: "cards should be not nil")
        
        accountsApiClient.getPaymentCards(cardsFilter: cardsFilter).done { getCardsResponse in
            
            print("\n")
            print(getCardsResponse.toJSON())
            expectedCards = getCardsResponse.items
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
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
