# chef_pal

flutter app for recipes

## Setup

<a href="https://flutter.dev/docs">Follow Flutter offcial docs for setup and installation</a>

## Running


```bash
    flutter run
    #within the chef_pal directory
```

---

## Lib Layout

In our lib folder which is our src folder for flutter we have seperated our code into sections based on app functionality.

### Models

The models hold the classes for Recipes, Ingredients and Recipe Steps. These classes are used for displaying Recipe Search data properly.

### Services

In our services folder we have the code for business logic such as connected to the Spoonaular API and making requests to it as well out out code for Firebase Authentification.

### Views

Our views folder is divided into utils and UI. Utils will hold any common widget that we may reuse for the app. The ui folder is then divided for different app pages if needed and holds all the frontend code for the app.

---

## API Calls

The Spoonacular API is used to get recipe information upon requests by the user

```dart
    final String _baseURL = "api.spoonacular.com";

    Map<String, String> parameters = {
      'query': query,
      'number': '15',
      'fillIngredients': true.toString(),
      'instructionsRequired': true.toString(),
      'addRecipeInformation': true.toString(),
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/complexSearch',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      Map<String, dynamic> data = json.decode(response.body);

      // ... remaining code
```

## Authentification

```dart
Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // ...
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // ...
}
```

---

## Firebase

Each user which is registered will have a unique user id. This user id will be used to assign each user a collection in our Firebase database to store their information. For more information on Firebase Firestore follow <a href="https://firebase.google.com/docs/firestore">Firestore Docs</a>

## Unit Testing

Unit Testing will be further implemented as the project grows inorder to maintain scalability. We are still in the process of learning the proper unit testing methods using Flutter. This should be addressed before demo 2.
