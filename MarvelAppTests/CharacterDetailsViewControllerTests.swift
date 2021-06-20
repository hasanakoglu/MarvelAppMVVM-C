//
//  CharacterDetailsViewControllerTests.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import XCTest

@testable import Marvel_App

class CharacterDetailsViewControllerTests: XCTestCase {
    var subject: CharacterDetailsViewController!
    var mockCharacter: MarvelCharacter!
    
    override func setUp() {
        let data = CharacterRequestTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[0]
        
        let navigationController = UINavigationController()
        subject = CharacterDetailsViewController(character: mockCharacter)
        navigationController.setViewControllers([subject], animated: false)
    }

    override func tearDown() {
        subject = nil
    }

    func testViewDidLoad() {
        subject.viewDidLoad()
        XCTAssertEqual(subject.title, mockCharacter.name)
    }
    
    func testDataSource() {
        XCTAssertTrue(subject.tableView.dataSource === subject)
    }
    
    func testTableViewCellTypeIsCharacterDetailsCell() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func testTableViewShouldHaveOneRow() {
        XCTAssertEqual(subject.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableViewCellDescriptionLabelTextShouldBeCorrect() {
        let data = CharacterRequestTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[1]
        
        subject = CharacterDetailsViewController(character: mockCharacter)
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, mockCharacter.description)
    }
    
    func testTableViewCellNoDescriptionTextShouldBeCorrect() {
        let cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CharacterDetailsTableViewCell
        XCTAssertEqual(cell?.descriptionLabel.text, "No Description")
    }
}

extension CharacterResponseModel {
    static func characterReponseModel(for data: Data) -> CharacterResponseModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let model = try? decoder.decode(CharacterResponseModel.self, from: data)
        return model!
    }
}
