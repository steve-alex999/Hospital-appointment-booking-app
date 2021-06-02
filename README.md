Medical appointment manager (leso):

The app supports two roles of user:
*Patient(USER)
*Admin(Hospital management)

This app helps patients manage their medical appointments (cancel, book and view) and also provides their live queue position.
This app uses flutter and firebase.

Steps for installation and running:

	App:

	1. We are using android studio for this, you can download it from web.
	2. Download this zip file and extract it.
	3. Open android studio -> click file -> new -> import project -> select the project file (leso main) in the extracted folder.
	4. Go to file -> project structure -> then in project sdk, select any virtual device or select "1.8 java version <version>".
	5. To get the dependencies, run
		 $ flutter pub get 
	5. If you picked "1.8 java version", then connect an andriod phone to the pc with usb.
	   Switch on the usb debugging in the phone, you may find it in the developer options in the device's settings.
	6. It will initiate, then wait for the play button to appear, then select the required device, then press the play.
	7. It may prompt you to install various plugins, but the prompt will be staright forward and you will be redirected to install the 
	   required plugins.
	8. It will compile and run on the connected device.

	Firestore Database:

	1. Add your app to existing firebase database of My first project (you need to request access first to use it), for that, refer https://firebase.google.com/docs/flutter/setup

	Then open the cloud functions in the firebase and do the following,

	Cloud Functions for server code:

	Install node in your pc.
	Open project folder and install firebase tool package using
	1. $ npm install -g firebase-tools this command
	2. Then login using 
		$ firebase login
	Select your existing project from firebase using $ firebase init functions

	Write the functions that are present in index.js. 
	We have used HTTP triggers for calling the cloud functions.
	
	After writing the cloud functions save the file and deploy using the below command
	$ firebase deploy --only functions
