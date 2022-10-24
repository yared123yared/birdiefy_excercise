# Birdiefy

## Excercise 1
- used package get it and injectable for dependancy injection
- use firebase as a back-end
- use firebase for authentication of user and creating user
- use sharedPreference for storing the logged in user information and access when ever it neeeded
## Excercise 2
- used Google Map Api for fetching nearby course 
- used stream for state managment
- followed repository pattern for fetching the api and integrate with the UI
- used geolocator package to locate the current latitude and longtiude and the search will be done for radius of 15,000
## Excercise 3
- used a package called tflite to implement classification of objects
- used to data set file called ssd_mobilenet.tflite and ssd_mobilenet.txt one, which are a data set model that helps the package to train before use. 
- used image picker for picking the image from galary.

## Challenges I faced
- The first chanllenge I got was impelmenting the score card, and do calculation there.
- the second one is the selecting widget when the holes are added to the round, I made my own custome widget extending carosul 
- the third one is for Excercise 3, I have got some challenge on classifyinc images into person and other object on finding the correct data set.

## Third Party ApI I used to fetch the course based on location
- Google Map Api

## How the Object Detection is working
- Select image from galary
- it will immediately drow and tell the part it identified it have high accuracy of identifying persons and also other objects.

## I have a feeling if the following things are changed...
- first the way holes are added to the round is a little bit complex, why don't we just use number picker instead of carosul slider?
- its better if we came up with a better UI experiance

