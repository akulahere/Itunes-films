# Take Home Project

This take-home project is an iOS application that uses Firebase for authentication and data storage. The app allows users to search for films, manage their favorite films, and view their profile information.

## Architecture

- MVVM

## Time Spent

- 20 hours were spent on the development of this project.

## Requirements

- Supports iPhone only
- Built with UIKit
- Supports portrait orientation
- Supports iOS 15 and later

## Features

1. **Login Page**: Allows users to register or log in to the system using their credentials (email and password).

2. **Tabbed Interface**: After successful login, the app navigates to a tabbed interface with three tabs: "Home", "Favorites", and "Profile".

3. **Home Tab**:
   - Search for films using the iTunes Search API.
   - Each film item displays a cover image, title, year, and genre.
   - Users can add films to their favorites.
   - Tapping on a film opens a detailed view with more information.

4. **Favorites Tab**: Displays a list of the user's favorite films.

5. **Profile Tab**: Shows the user's profile picture, name, and other relevant information. Also provides the option to log out.

6. **Local Data Storage**: This feature was not implemented.

7. **Sharing**: (Optional) Ability to share content (film links) with others.
