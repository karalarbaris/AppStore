1.  Write a JSON parser that can consume the Appstore Search API and render a list of searchable objects.
    -   Each result must be rendered similar to the AppStore rows with pixel perfect precision.
    -   Tapping on a row will take you to the details screen for each app.
    -   Tapping on a screenshot will present a fullscreen modal
    -   There needs to be a delay on search when user is typing

2. Fetch reviews for each app

3. Implement horizontal snapping on screenshots and reviews

4. Show differences between completion handlers and async/await. How do you use Continuations?

5. Can you implement Image caching to reduce cost of loading images?


### [Available APIs]

Search:

```
https://itunes.apple.com/search?term=\(term)&entity=software
```

App Details:

```
https://itunes.apple.com/lookup?id=\(trackId)
```

Reviews:

```
https://itunes.apple.com/rss/customerreviews/page=1/id=\(trackId)/sortby=mostrecent/json?l=en&cc=us
```

### [Topics covered]

-   Rendering SwiftUI views with NavigationStack, ScrollView, Searchable, GeometryReader, AsyncImage, etc.
-   Fetching JSON with Async/Await
-   Decoding JSON with Codable Protocol
-   ScrollView snapping with scrollTargetLayout and scrollTargetBehavior
-   iOS 17 #Observable macro
-   Transform old completion handlers into async await code with Continuations
-   Image caching using NSCache and AsyncImage
