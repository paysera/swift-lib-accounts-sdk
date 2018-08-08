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
        let token =  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoiYXV0aF9hcGkiLCJleHAiOjE1MzM3Nzc2NzEsImp0aSI6ImhPZE9JM05kMkZvbVB3YzFKODNVelBOT2dkQkRnM1NiIiwicHNyOnMiOlsibG9nZ2VkX2luIl0sInBzcjp1IjoiNDUxNzQ1IiwicHNyOnNpZCI6Ik9BNmpYMHFtUUZkQmRoVHQ3OVc1clMtbThLbnYxOXNZIiwicHNyOmEiOnsidXNlcl9pZCI6IjQ1MTc0NSJ9LCJpYXQiOjE1MzM3MzQ0NzF9.RcpUQDIjRjmjrMzE_pdW0y87npLqBvGGhG2lUBLtasXoZhYD79D2Csu_L0i3gWQAQuPyMRdTs3ZaZLybF05j4kkSm7-j34lQMTMmatkWv_aiS-vm5qTVZLL3OeJ_knGHmQ7Vyo2OwjBfemYP1Rr2gt2_XM3syPeGs8-SgHZKGvd0by04xAsr_QibiFq1ikjbicbTOv-rNqE-v8PLQbVKExt7I3pVwUHnENi4_rmbA6rxwmcAsNjfEnmuJCzifZmwDTSf2KHAotwKQtS2NBgbbOaE2i_--kwVCT6WXwK357058nqYRB-DgmWDe1SMzFpCZtBOQntPJlNgUsGhf9PUZR6mFVlpEe316fjVNRXlX6gIP1iwN3Z6bLpEolftH5UWf4f2OourrIEAr0O1byRs8gXnthaX2FHWts3sr32EtZbeFbRV1QroYTKEPOHp6V-mQz3833n2QQMo4pCtTNQ53w6viFh4dGl-Lwi1uRvWhEbDw0l6grpme9gk95tIYC7AWinvjmpzUV-1A_T3vijxwH04nmJ6E9_ksAbwnR-5ZJqx4P0_S5SujLWJbemMmb2XEwZpZh6_JvOr9iqSn6EOzK10ZayTWLXgYcJHl2sLqW6lhdfFSVa7I-VdTx4bYqZdErxd6ebJSxFn7LbVAmbJg6Td5swjKxC1havaUQTEWMc"
        
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
    
    
    func testGetCardLimit() {
        
        var cardLimit: PSPaymentCardLimit?
        let expectation = XCTestExpectation(description: "balance information should be not nil")
        
        accountsApiClient.getPaymentCardLimit(accountNumber: "EVP1610001845744").done { paymentCardLimit in
            cardLimit = paymentCardLimit
            
            print("\n")
            print(paymentCardLimit.toJSON())
            expectation.fulfill()
            }.catch { error in
                print("\n")
                print((error as! PSAccountApiError).error)
                print((error as! PSAccountApiError).description)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(cardLimit)
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
