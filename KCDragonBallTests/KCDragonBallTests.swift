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
    private var sutTransform: Transformation!
    
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
    
    // Comprobar que existe una transformacion con el nombre de Kaio-Ken
    func test_Transformation_withName_kaioken_exist() {
        // Given / Arrange
        let transformation = "Kaio-Ken"
        
        // When / Act
        sutTransform = Transformation(
            name: transformation,
            id: "x",
            photo: "x",
            description: "x"
        )
        
        // Then / Assert
        XCTAssertEqual(sutTransform.name, transformation)
    }
}
