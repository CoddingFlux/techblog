<!DOCTYPE html>

<%@page import="com.techblog.securityconfig.FirebaseConfigUtil"%>
<%@page import="com.techblog.entitties.CustomProperty"%>
<%@ page errorPage="error"%>

<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Cross-Origin-Opener-Policy" content="unsafe-none">
<meta http-equiv="Cross-Origin-Resource-Policy" content="cross-origin">
<title>Document</title>

<%@ include file="includes/links.jsp"%>

<!-- Add SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="module">
    // Import Firebase modules
    import { initializeApp } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-app.js";
    import { getAuth, GoogleAuthProvider, signInWithPopup } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

    // Firebase configuration using properties file
    const firebaseConfig = {
        apiKey: "<%=FirebaseConfigUtil.get("firebase.apiKey")%>",
        authDomain: "<%=FirebaseConfigUtil.get("firebase.authDomain")%>",
        projectId: "<%=FirebaseConfigUtil.get("firebase.projectId")%>",
        storageBucket: "<%=FirebaseConfigUtil.get("firebase.storageBucket")%>",
        messagingSenderId: "<%=FirebaseConfigUtil.get("firebase.messagingSenderId")%>",
        appId: "<%=FirebaseConfigUtil.get("firebase.appId")%>",
        measurementId: "<%=FirebaseConfigUtil.get("firebase.measurementId")%>"
    };

    // Initialize Firebase
    const app = initializeApp(firebaseConfig);
    const auth = getAuth(app);

    // Google Sign-In Function
    window.googleSignIn = function () {
        const provider = new GoogleAuthProvider();

        signInWithPopup(auth, provider)
            .then((result) => {
                const user = result.user;

                // Send ID token to backend
                user.getIdToken().then(idToken => {
                    return fetch("<%=application.getContextPath()%>/GoogleSignInServlet", {
                        method: "POST",
                        mode: "cors",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "idToken=" + encodeURIComponent(idToken)
                    });
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.json(); // Expecting JSON response from backend
                })
                .then(data => {
                    if (data.status === true) {
                        // Fix: Ensure `Swal.fire` is called correctly
                        Swal.fire({
                            title: "Sign-In Successful",
                            text: "We are redirecting you to the index page...",
                            icon: "success",
                            allowOutsideClick: false
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = "<%=application.getContextPath()%>/index";
                            }
                        });
                    } else {
                        Swal.fire({
                            title: "Sign-In Failed",
                            text: data.message || "Something went wrong.",
                            icon: "error"
                        });
                    }
                })
                .catch(error => {
                    console.error("❌ Backend Error:", error.message);
                    Swal.fire({
                        title: "Error",
                        text: "Google Sign-In failed. Please try again.",
                        icon: "error"
                    });
                });
            })
            .catch((error) => {
                console.error("❌ Google Sign-In Error:", error.message);
                Swal.fire({
                    title: "Google Sign-In Failed",
                    text: error.message,
                    icon: "error"
                });
            });
    };
</script>


</head>

<body>

	<%@ include file="includes/nav.jsp"%>

	<!-- banner -->

	<div class="container-fluid m-0 p-0 banner-clip-path">
		<div class="bg-light pt-5 pb-5 primary-background">
			<div
				class="container p-4 text-white pb-5 d-flex align-items-center justify-content-center">
				<div class="card text-dark">
					<div class="card-header primary-background text-center lh-1">
						<i class="ri-login-circle-line fs-1 text-white"></i>
						<h2 class="text-white">Login</h2>
					</div>

					<div class="card-body">
						<form id="LoginFormID"
							action="<%=application.getContextPath()%>/LoginServlet"
							method="post">
							<div class="mb-3">
								<label for="userEmail" class="form-label">Email address</label>
								<input type="email" name="user_email" class="form-control"
									id="userEmail" aria-describedby="emailHelp" required="required">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>

							<div class="mb-3">
								<label for="userPassword" class="form-label">Password</label>

								<div class="eye">
									<input type="password" name="user_password"
										class="form-control" id="userPassword" required="required"/> <i
										class="ri-eye-close-fill eye-color" id="close"></i> <i
										class="ri-eye-fill eye-color" id="open"></i>
								</div>
							</div>

							<div id="form_refreshlogin" class="mb-1 text-center"
								style="font-size: 1.5rem; display: none;">
								<span class="fa fa-refresh fa-spin"></span>
							</div>

							<div id="loginbtn" class="text-center mb-2">
								<button type="submit"
									class="btn btn-md primary-background text-white">LogIn</button>
							</div>

							<!-- Google Sign-In Button Added Below -->
							<div id="googleSignInBtn" class="text-center mb-2">
								<button type="button"  onclick="googleSignIn()"
									class="btn btn-outline-dark ">
									<img style="width:1.5rem" class="rounded-circle" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfi4hCQ20qt-nD-SL7HsRDtdubBCSX5bzGzJNEIg-1NHokYlBcdZM3jT0&usqp=CAE&s"> Sign in with Google
								</button>
							</div>

							<div class="text-center">
								<p>
									Don't have an account? <a
										href="<%=application.getContextPath()%>/register"
										class="text-primary">Sign Up</a>
								</p>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /banner -->

	<%@ include file="includes/footer.jsp"%>
	<%@ include file="includes/scripts.jsp"%>

</body>
</html>