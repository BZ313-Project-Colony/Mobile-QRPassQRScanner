## Project Documentation

### Overview
This documentation provides an overview of a Flutter project that appears to be a mobile application for managing events. The application includes features such as user authentication, event listing, participant management, and a QR code scanner.

### Project Structure
The project is organized into several Dart files, each serving a specific purpose. Here's a brief description of each file:

1. **main.dart**: The main entry point of the Flutter application. It initializes the app and sets up the home screen.

2. **login_screen.dart**: Defines the login screen UI.

3. **login_body.dart**: Handles the UI and logic for the login screen. It communicates with the `ApiService` for user authentication.

4. **date_utils.dart**: Contains a utility function (`addHoursAndFormat`) for manipulating and formatting date objects.

5. **token_storage.dart**: Manages the storage and retrieval of authentication tokens using the `shared_preferences` package.

6. **token_jobs.dart**: Extends `TokenStorage` and includes additional methods for handling token-related tasks, such as obtaining event lists.

7. **api_service.dart**: Contains methods for making HTTP requests to the API. Handles user authentication, fetching event lists, and retrieving participants for an event.

8. **event_list_body.dart**: Defines the UI for displaying a list of events. Uses the `TokenEventListJobs` class to obtain and display the list of events.

9. **qr_scanner.dart**: Implements a QR code scanner using the `qr_code_scanner` package. Allows users to scan QR codes and perform actions such as confirmation or rejection of tickets.

10. **qr_home_page.dart**: Provides a simple home page with a button to navigate to the QR code scanner.

11. **participants.dart**: Defines a `Participant` class and includes a factory method for creating `Participant` objects from a string.

12. **participant_updates.dart**: Manages API requests for updating participant statuses (confirmation or rejection).

13. **participant_model.dart**: Defines the `ParticipantModel` class, representing a participant in an event.

14. **events_model.dart**: Defines the `EtkinlikModel` class, representing an event.

15. **api_constants.dart**: Contains constant values for API endpoints.

16. **event_details_page.dart**: Displays detailed information about a specific event, including a list of participants.

### Key Features

1. **User Authentication**: The app allows users to log in using a username and password. The `ApiService` handles authentication requests.

2. **Event Listing**: The `EventApi` screen displays a list of events, and users can click on an event to view detailed information.

3. **Participant Management**: The `EventDetailsPage` screen shows detailed information about an event, including a list of participants. Participants can be confirmed or rejected using the QR code scanner.

4. **QR Code Scanner**: The `QrScanner` screen allows users to scan QR codes. The scanned result triggers actions such as confirming or rejecting a participant's ticket.

### Usage Guidelines

1. **Login Screen**: Users must log in using a valid username and password.

2. **Event List**: After logging in, users are directed to the event list. Clicking on an event navigates to the event details page.

3. **Event Details**: The event details page provides information about the event, including participants. Users can scan QR codes to confirm or reject participants.

4. **QR Scanner**: Accessible from the home page or event details page, the QR scanner allows users to interact with participants' QR codes.

### API Integration

- The `ApiService` class handles communication with the backend API, including user authentication and retrieving event-related data.

- Token management is implemented in the `TokenStorage` and `TokenEventListJobs` classes, ensuring secure and efficient handling of authentication tokens.

- The `ParticipantUpdates` class handles API requests related to participant status updates, such as confirmation or rejection.

### Future Improvements

1. **User Feedback**: Implement more informative and user-friendly feedback messages during API interactions.

2. **Error Handling**: Enhance error handling mechanisms to provide meaningful messages to users.

3. **UI/UX Enhancements**: Consider refining the user interface and experience for better usability.

4. **Security**: Regularly review and update security measures to ensure the safety of user data.

### Conclusion

This Flutter project demonstrates the implementation of a mobile application for event management, covering user authentication, event listing, participant management, and QR code scanning. The well-structured code and modular design make it easier to maintain and extend the functionality in the future.
