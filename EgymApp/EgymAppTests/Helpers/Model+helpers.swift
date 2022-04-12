//
//  Model+helpers.swift
//  EgymAppTests
//
//  Created by Nithin Michael on 4/12/22.
//

@testable import EgymApp

extension NewsData {
    static func generate() -> NewsData
    {
        NewsData(
            status: "",
            copyright: "",
            section: "",
            lastUpdated: "",
            numResults: 1,
            results: [News(
                section: "",
                subsection: "",
                title: "Test title",
                abstract: "Test description",
                url: "",
                uri: "",
                byline: "by nithin",
                itemType: .article,
                updatedDate: "",
                createdDate: "",
                publishedDate: "",
                materialTypeFacet: "",
                kicker: "",
                desFacet: [""],
                orgFacet: [""],
                perFacet: [""],
                geoFacet: [""],
                multimedia: [Multimedia(url: "",
                                        format: .threeByTwoSmallAt2X,
                                       height: 100,
                                       width: 100,
                                        type: .image,
                                        subtype: .photo,
                                       caption: "",
                                       copyright: "")],
                shortURL: "")])
    }
}
