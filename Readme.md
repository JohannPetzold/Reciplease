# Reciplease - Find best recipe
[![Generic badge](https://img.shields.io/badge/version-v1.0-blue?style=flat-square)](https://shields.io/) [![Generic badge]https://img.shields.io/badge/language-Swift-green?style=flat-square](https://shields.io/) [![Generic badge]https://img.shields.io/badge/platform-iOS-blue?style=flat-square](https://shields.io/) [![Generic badge]https://img.shields.io/badge/iOS-14.1%2B-green?style=flat-square](https://shields.io/)

Reciplease is an iOS app that allow user to search for recipes using ingredients.

## Technologies

- Xcode 13.0
- Swift 5.5
- UIKit, CoreData
- Alamofire

## API

This project use the API Recipe Search from Edaman. 
- Sign up: https://developer.edamam.com/edamam-recipe-api
- Documentation: https://developer.edamam.com/edamam-docs-recipe-api

## Compatibility

- iOS 14.1 to iOS 15
- iPhone SE (2nd gen) to iPhone 13 Pro Max
- Run on Portrait 

## Features

- Search for recipes using ingredients
- Load a lot of recipes from Recipe Search API
- Visit the recipe's website using an in-app WebView
- Add recipes to favorites so you can consult at any time

## Launch

Add a Constants.swift file with 2 constants for your Recipe Search API Keys:
- APPID: String
- APPKEY: String
