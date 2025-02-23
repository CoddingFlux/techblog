<!DOCTYPE html>
<%@page import="com.techblog.entitties.CustomProperty"%>
<%@ page errorPage="error"%>

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
		<div class="bg-light pt-5 pb-5 primary-background">
			<div
				class="container p-4 text-white pb-5 d-flex align-items-center justify-content-center">
				<div class="card text-dark">
					<div class="card-header primary-background text-center lh-1">
						<i class="ri-login-circle-line fs-1 text-white"></i>
						<h2 class="text-white">Login</h2>
					</div>
				<%-- 	<%
					CustomProperty cproProperty = (CustomProperty) session.getAttribute("customProperty");
					if (cproProperty != null) {
					%>

					<div class="<%=cproProperty.getCssClass()%>" role="alert">
						<%=cproProperty.getContent()%>
					</div>

					<%
					}
					session.removeAttribute("customProperty");
					%>
 --%>
					<div class="card-body">
						<form id="LoginFormID" action="<%=application.getContextPath()%>/LoginServlet"
							method="post">
							<div class="mb-3">
								<label for="userEmail" class="form-label">Email address</label>
								<input type="email" name="user_email" class="form-control"
									id="userEmail" aria-describedby="emailHelp">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>

							<div class="mb-3">
								<label for="userPassword" class="form-label">Password</label>

								<div class="eye">
									<input type="password" name="user_password"
										class="form-control" id="userPassword" /> <i
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
