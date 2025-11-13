if (typeof importScripts === "function") {
	importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
	importScripts(
		"https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js",
	);
	const firebaseApp = firebase.initializeApp({
		apiKey: "AIzaSyCdpX-Kz_z8r39cj-XK8dfbQoCtAmJdJR0",
		authDomain: "akademove-7d5e2.firebaseapp.com",
		projectId: "akademove-7d5e2",
		storageBucket: "akademove-7d5e2.firebasestorage.app",
		messagingSenderId: "755870082701",
		appId: "1:755870082701:web:ddee912f59184c556364c4",
	});

	firebase.messaging(firebaseApp);

	self.addEventListener("install", () => {
		console.log("installed SW!");
	});
}
