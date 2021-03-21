//const functions = require("firebase-functions");

const http = require("http");
const https = require("https");
const mHostname = "www.yourdomain.info";
const mPath = "/path/file.php?mode=markers";

const options = {
  hostname: mHostname,
  port: 80, // should be 443 if https
  path: mPath,
  method: "GET",
  headers: {
    "Content-Type": "application/json", //; charset=utf-8',
  },
};

var rData = "";
const req0 = http
  .request(options, (res0) => {
    res0.setEncoding("utf8");

    res0.on("data", (d) => {
      rData += d;
    });
    res0.on("end", function () {
      console.log("got pack");
      res.send("ok");
    });
  })
  .on("error", (e) => {
    const err = "Got error:" + e.message;
    res.send(err);
  });
req0.write("body"); //to start request
// var SpoonacularApi = require('spoonacular_api');

// var defaultClient = SpoonacularApi.ApiClient.instance;
// // Configure API key authorization: apiKeyScheme
// var apiKeyScheme = defaultClient.authentications['apiKeyScheme'];
// apiKeyScheme.apiKey = "a6ce9d76a0cb413cab0c9b5a8636407c"
// // Uncomment the following line to set a prefix for the API key, e.g. "Token" (defaults to null)
// //apiKeyScheme.apiKeyPrefix['apiKey'] = "Token"

// var api = new SpoonacularApi.DefaultApi()
// var username = 'dsky'; // {String} The username.
// var hash = '4b5v4398573406'; // {String} The private hash for the username.
// var inlineObject11 = new SpoonacularApi.InlineObject11(); // {InlineObject11}
// var callback = function(error, data, response) {
//   if (error) {
//     console.error(error);
//   } else {
//     console.log('API called successfully. Returned data: ' + data);
//   }
// };
// api.addToMealPlan(username, hash, inlineObject11, callback);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
