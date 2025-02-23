<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="error" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<%@ include file="includes/links.jsp"%>
</head>

<body>


	<%@ include file="includes/nav.jsp"%>

	<!-- banner -->

	<div class="container-fluid m-0 p-0 banner-clip-path">
		<div class="bg-light pt-5 pb-5 rounded primary-background">
			<div
				class="container text-white pb-5  d-flex align-items-center justify-content-center">
				<div class="card text-dark cswidth">
					<div class="card-header primary-background text-center lh-1">
						<i class="ri-user-smile-line fs-1 text-white"></i>
						<h2 class="text-white">Sign Up</h2>
					</div>
					<div class="card-body">

						<form id="user_form_id" action="RegisterServlet" method="POST">
							<div class="mb-4">
								<label for="userName" class="form-label">User Name</label> <input
									type="text" class="form-control" id="userName" name="user_name"
									required="required" spellcheck="true" />
							</div>

							<div class="mb-4">
								<label for="userEmail" class="form-label">Email address</label>
								<input type="email" class="form-control" id="userEmail"
									name="user_email" aria-describedby="emailHelp"
									required="required" />
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>

							<div class="mb-4">
								<label for="userPassword" class="form-label">Password</label>
								<div class="eye">

									<input type="password" class="form-control" id="userPassword"
										name="user_password" required="required" /> <i
										class="ri-eye-close-fill eye-color" id="close"></i> <i
										class="ri-eye-fill eye-color" id="open"></i>
								</div>
							</div>


							<div class="mb-4">
								<label class="form-label">Select Gender</label><br> <input
									type="radio" class="form-check-input" name="user_gender"
									value="Male" required="required"> Male <input
									type="radio" class="form-check-input" name="user_gender"
									value="Female"> Female <input type="radio"
									class="form-check-input" name="user_gender" value="Other">
								Other
							</div>

							<div class="mb-4">
								<textarea name="user_about" class="form-control" rows="5"
									cols="" placeholder="Write something about yourself"></textarea>
							</div>

							<div class="mb-3 form-check">
								<input type="checkbox" name="user_check"
									class="form-check-input" id="exampleCheck1"> <label
									class="form-check-label" for="exampleCheck1"> Agree
									Terms &amp; Conditions</label>
							</div>

							<div id="form_refresh" class="mb-1 text-center"
								style="font-size: 1.5rem; display: none;">
								<span class="fa fa-refresh fa-spin"></span>
							</div>

							<div id="form_btn" class="text-center mb-2">
								<button type="submit"
									class="btn btn-md primary-background text-white">Submit</button>
							</div>
							<div class="text-center">
								<p>
									Already have an account? <a
										href="<%=application.getContextPath()%>/login"
										class="text-primary">Log In</a>
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