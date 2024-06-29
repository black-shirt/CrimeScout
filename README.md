# CrimeScout

A mobile application that maps real-time crime reports onto a dynamic map interface. Users can seamlessly submit detailed crime reports and view others' submissions, fostering a safer community through transparent information sharing.

Technical requirements: Android Studio, Flutter, Python 3, Fritzing, Esp32 Cam Module, Sound sensor, AWS, Firebase, Deep Learning

Functionality: The app has three types of users: citizens, police and admin. Citizens can  add reports of crime with details like date, time, location and media like photos and videos. To protect their identity, they can choose to do this anonymously. Citizens can view crimes that have happened on a real time map inside the app. They can also be notified of criminal activity in the app.
The police views reports and can verify them after confirming them. They can also view the real time map of crimes. The police have access to camera feeds from inside the app. The police can send out notifications to citizens and other police officers.
The admin can view all the notifications, reports and view them on the map. They can choose to delete reports and notifications if deemed fake or unconfirmed.

Features: Citizens can sign up with Firebase, and get real-time reports of crime on a map too. The app automatically fetches the citizen's location when reporting a crime using the geolocator library. If the same types of crime are reported in the same proximity, a heatmap is shown covering a large radius.

Architecture: The database is a NoSQL one and some APIs are stored on AWS. One API is deployed locally through ngrok.

The dataset which the model was trained on consists of 30 types of crimes. But for now we have added 5 pivotal crimes. The ANN model which predicts the number of crime cconsists of 5 layers of dense neural networks and give an integer output. The 'testing_model' have torch library and the model is called and runned for a single test case. The pytorch model is saved as 'crime.pth' with .pth extension. 

In IoT for schematic diagram we have used Fritzing software and used esp32 cam module and sound sensor library. The .ino files captures the data from sensor and prints it to serial monitor. For later purposes, we will sent the data to the cloud via API.

The odoo_server.py file sets up a Flask web server to provide predictions using crime.pth. The app is run locally and served online through ngrok.
