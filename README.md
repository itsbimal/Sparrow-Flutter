# Q&A Platform | Sparrow Network 🕊️

Everybody has a curious mind with lots of questions, every moment. So, to express the questions and get answers from various creative minds, from different prospective in a moment, can be a challenge. So, ‘Sparrow Network’ is all about connecting every curious minds.

## Features of Sparrow Network

-   It’s a platform, where every user has ability to create a questions or answer to any posted     questions in a second.
-	Direct Chat between end users, implemented through Socket.IO
-	Every post can have multiple answers by same or multiple users, and it can be liked by every user
-	Questions can be searched by keywords and user by username.
-	Can visit other user profile and follow. Also, see their specific posts
-	Change password, edit or delete questions, sensors, wear OS and so on.

## Technology used.
1.	`Flutter, for app development`,
Because it is a cross-platform framework, it allows programmers to write code once and they can use it on multiple platforms. This means that a single version of an application runs on both iOS and Android. This consequently saves a lot on the overall cost of developing and launching the app.

2.	`Node JS as backend`,
because Node.js works well with a real-time handling large amount of information and can be scaled and offers relatively higher performance.

3.	`Mongo DB as core database`
because it easy for developers to store structured or unstructured data. It uses a JSON-like format to store documents. So comparatively better than relational database system.

## Some Challenges
-	User authentication requires security guidelines to be followed, handling of auth token, hashing of OTP includes security challenges.
-	API integration with future builder sometimes doesn’t fetch data from the server
-	Implementing offline storage through HIVE includes socket exceptions

## Future works
-	Implementation of biometric authentication system, so user can have safety in auto login.
-	Live voice room for question discussion through webRTC module.

## Design pattern
This project is based on "Repository Design Pattern", which acts as an in-memory domain object collection, bridging the domain and data mapping layers. Using this method to save data not inheritable from the network on the device's local storage, our code enable offline caching and provide quicker data access. If the device is connected to the internet, it will download current report data from the back-end server and save it locally before showing what is already there. Otherwise, even if the device is offline, it will instantly retrieve information kept in a local data source such as SQLite. Using the repository technique will make it easier to check and maintain, perhaps reducing development-related concerns.

 Why this pattern is used
- Better componentization to facilitate the maintenance of the code
- repository module enables the use of multiple backends and easy for testing the codes
- The repository makes sure the app's data is as accurate and current as possible, giving users the optimal experience even when the app is offline. The repository makes sure the app's data is as accurate and current as possible, giving users the optimal experience even when the app is offline. The repository makes sure the app's data is as accurate and current as possible, giving users the optimal experience even when the app is offline.


## State management
There is multiple state management library used for state management for overall application

- `Provider` with Change Notifier
Several features use provider as state management. The main section is Dark Mode, it observes the changes in real time and changes the theme accordingly. Also, the real time messaging uses provider to update the widget of received or send messages in chat screen

- `GetX` state management
Like and follower’s features uses GetX for live updating followers and likes locally in a application. 

 
## Conclusion
Thus, the Q&A platform is build using Flutter framework. It includes various useful features that has been implemented including Realtime chat with socket.io the persistent data storage is used for offline database and state management is done in various sectors and testing were done to ensure the features are working perfectly. So overall the application is running and tested 

## Appendix

<img src="https://user-images.githubusercontent.com/69587963/182186477-ec8f6b0f-6146-4866-b959-b472a80b5b50.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182186500-b6bc5ca4-68be-45f7-a6a6-56c74583f87f.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182186526-a1214bdf-44aa-4aa5-83a4-199bfbada0fa.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182186599-df35de3a-ca0d-4b29-8d59-cb5302221eaf.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182186939-a5a29ea6-848f-4e4f-a8d0-c0116055a3af.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187366-00f21537-89ed-42bc-83e8-b4f97a84a92a.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187658-af1c6ee3-99bf-4ee0-a0d5-ff1e2ed5503b.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187403-3cb413e4-7987-4645-8b0d-c97e05176dff.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187444-972323af-7e38-44fa-89c8-a7e38b3ebaf0.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182186995-7627799b-d5ab-46e6-b18e-8a78417162aa.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187156-35313531-4c78-4708-9247-9fb40fce5589.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187206-b6cb2870-8c12-40e7-ad6d-89951135465a.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187507-89d6940b-0e00-49a9-b6f1-a1dd0a165021.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187537-941b6d70-ec77-4d50-9ca7-49ee0675c747.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187556-5db2ffc5-6cf7-4932-91d6-0f7373eb5448.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187719-3b8b7933-89db-4e2c-88d1-a408381abf20.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182187741-63c5ace9-1f76-4db2-b2ca-2ce2b446a438.jpg" width="30%"></img> <img src="https://user-images.githubusercontent.com/69587963/182190779-e7226166-bb12-401c-b8e7-fc8f91c79b06.jpg" width="30%"></img> 




