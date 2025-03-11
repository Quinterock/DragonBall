//
//  KCDragonBallTests.swift
//  KCDragonBallTests
//
//  Created by Luis Quintero on 5/3/25.
//

import XCTest
@testable import KCDragonBall

final class HeroTests: XCTestCase {
    private var sut: Hero!
    
    func test_init_withName_isGoku() {
        // Given/ Arrange
        let name = "Goku"
        
        // When/ Act
        sut = Hero(
            id: "some_id", 
            name: name, 
            favorite: false, 
            photo: "", 
            description: "some-description"
        )
        
        // Then/ Assert
        XCTAssertEqual(sut.name, name)
    }
}
