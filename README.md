# ITSector-challenge

  
This is the project to the ITSector challenge described below.


![Swift ](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)
![Pattern ](https://img.shields.io/badge/Pattern-MVVM--C-orange.svg?style=flat)
 

## Demo

![ITSector Demo](http://www.lucascorrea.com/images/ITSector.gif)
http://www.lucascorrea.com/images/ITSector.gif

## Build:
  
- Xcode version  11.6

- Design pattern MVVM-C

- Swift 5.2.4

- iPhone/iPad
  

## ITSector - iOS Code Challenge


### Book Store

- Create a new app named “BookStore_[yourName] on a public Github, send us the link when you are finished.

- Book Store consists on showing a simple 2-column list of available books about iOS development. Using google’s api for books, the app should fetch and display the Thumbnail of a few books at a time and load more as the user scroll’s through the list.

- Rest API: https://developers.google.com/books/docs/v1/getting_started#REST

- Example API Call: https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0

- The app should be usable in both iPhone and iPad.

- The list should also have a button to filter/show only books that the user has set as favorite.

- When the user clicks on one of the books, the app should present a detailed view displaying the most relevant information of the book: Title, Author, Description and, if available, a Buy link.

- In the detail view, the user can also favorite or unfavorite a book. This option should be stored locally so it persists through each app usage.

- Clicking on the Buy link should open the link on safari.
