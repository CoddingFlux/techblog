<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entitties.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entitties.User"%>

<nav
	class="navbar navbar-expand-lg navbar-dark primary-background d-flex justify-content-between">
	<div class="container-fluid">
		<a class="navbar-brand" href="index"> <span><i
				class="ri-blogger-line"></i></span>TechBlog
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="<%=application.getContextPath()%>/posts"><span><i
							class="ri-leaf-line"></i></span>Posts</a></li>

				<%
				User user1 = (User) session.getAttribute("user");
				if (user1 == null) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=application.getContextPath()%>/login"><i
						class="ri-login-circle-line"></i> Login</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=application.getContextPath()%>/register"><span><i
							class="ri-user-smile-line"></i></span> Register</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="#"
					data-bs-toggle="modal" data-bs-target="#postmodal"><i
						class="ri-login-circle-line"></i> Do a Post</a></li>
				<%
				}
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<span><i class="ri-dropdown-list"></i></span> Dropdown
				</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="#">Programming
								Language</a></li>
						<li><a class="dropdown-item" href="#">Project
								Implementation</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li><a class="dropdown-item" href="#">Data Structure</a></li>
					</ul></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=application.getContextPath()%>/contact"><span><i
							class="ri-contacts-line"></i></span> Contact</a></li>
			</ul>
			<!-- Logout as a right-aligned list item -->
			<%
			if (user1 != null) {
			%>

			<div>
				<!-- span trigger modal -->
				<span class="text-white me-3 pointer" data-bs-toggle="modal"
					data-bs-target="#profile-modal"><i
					class="ri-user-line usericon"></i> <%=user1.getuName()%></span> <a
					href="<%=application.getContextPath()%>/LogoutServlet"
					class="btn btn-outline-light">Logout</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
</nav>

<%
if (user1 != null) {
%>

<!-- profile modal -->

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header primary-background text-white">
				<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container">

					<div class="text-center">
						
						<%
							String climage = (!user1.getuProfile().contains("https")) ? "assets/pics/"+user1.getuProfile() : user1.getuProfile();
						%>

						<img class="image-fluid profile-pics"
							src="<%=climage%>"
							alt="user_profile" loading="lazy"/>

						<h5 class="lead mt-3 mb-3"><%=user1.getuName()%></h5>
					</div>
					<div id="user_detail">

						<table class="table table-striped">

							<tbody>
								<tr>
									<th>Email</th>
									<td><%=user1.getuEmail()%></td>

								</tr>
								<tr>
									<th>Gender</th>
									<td><%=user1.getuGender()%></td>

								</tr>
								<tr>
									<th>About</th>
									<td><%=user1.getuAbout()%></td>

								</tr>

								<tr>
									<%
									String time = user1.getTimestamp() == null ? "" : user1.getTimestamp().toString();
									%>
									<th>Registered on :</th>
									<td><%=time%></td>
								</tr>
							</tbody>
						</table>

					</div>

					<div class="container" id="user_edit" style="display: none;">
						<div class="">
							<a href="#" class="btn btn-outline-secondary col-12 mb-3"
								data-bs-toggle="collapse" data-bs-target="#user_personal">Edit
								Personal Information</a>
							<div class="collapse" id="user_personal">
								<form id="updateuprofile" action="UpdateProfile" method="POST"
									enctype="multipart/form-data">
									<table class="table table-striped mt-3">
										<tbody>

											<tr>
												<th><label for="userProfile">Choose image</label></th>
												<td><input type="file" name="user_profile"
													id="userProfile" class="form-control" /></td>
											</tr>

											<tr>

												<th><label for="userName" class="form-label">User
														Name</label></th>
												<td><input type="text" class="form-control"
													id="userName" name="user_name"
													value="<%=user1.getuName()%>" required="required"
													spellcheck="true" /></td>

											</tr>

											<tr>
												<th><label for="userEmail">Email</label></th>
												<td><input type="email" name="user_email"
													id="userEmail" value="<%=user1.getuEmail()%>"
													class="form-control" required="required" /></td>
											</tr>

											<tr>
												<th><label for="userGender">Gender</label></th>

												<td><input type="radio" name="user_gender"
													id="userGender" value="Male" class="form-check-input"
													required="required"
													<%="Male".equals(user1.getuGender()) ? "checked" : ""%> />
													Male <br> <input type="radio" name="user_gender"
													id="userGender" value="Female" class="form-check-input"
													required="required"
													<%="Female".equals(user1.getuGender()) ? "checked" : ""%> />
													Female <br> <input type="radio" name="user_gender"
													id="userGender" value="Other" class="form-check-input"
													required="required"
													<%="Other".equals(user1.getuGender()) ? "checked" : ""%> />
													Other</td>

											</tr>
											<tr>
												<th><label for="userAbout">About</label></th>
												<td><textarea name="user_about" id="userAbout" rows="3"
														placeholder="Write something about yourself"
														class="form-control" required="required"><%=user1.getuAbout()%></textarea></td>

											</tr>

											<tr>
												<th>Regitered on :</th>
												<td><%=time%></td>

											</tr>
											<tr>
												<td colspan="2" class="text-center">
													<button id="btnpprosave"
														class="btn primary-background text-white col-8"
														type="submit">Save</button> <span id="spnpproloader"
													class="fa fa-refresh fa-spin fa-2x"
													style="font-size: 1.5rem; display: none;"></span>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>

						<div class="">
							<a href="#" class="btn btn-outline-secondary col-12"
								data-bs-toggle="collapse" data-bs-target="#user_password">Change
								Password</a>

							<div class="collapse" id="user_password">
								<form id="changePassword" action="UpdatePassword" method="post">
									<table class="table table-striped mt-3">
										<tbody>
											<tr>
												<th><label for="userPassword1" class="form-label">Password</label></th>
												<td><input type="password" class="form-control"
													id="userPassword1" name="user_password1"
													required="required" /></td>
											</tr>

											<tr>
												<th><label for="userPassword2" class="form-label">Confirm
														Password</label></th>
												<td><input type="password" class="form-control"
													id="userPassword2" name="user_password2"
													required="required" /></td>

											</tr>

											<tr>

												<td colspan="2" class="text-center"><span id="massage"
													class="col-12"></span></td>

											</tr>

											<tr>

												<td id="btnchpass" colspan="2" class="text-center"><span
													id="spchloader" class="fa fa-refresh fa-spin fa-2x mb-2"
													style="font-size: 1.5rem; display: none;"></span>
													<button class="btn primary-background text-white col-8"
														type="submit">Save</button></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer d-flex justify-content-center">
				<button type="button" class="btn btn-primary"
					data-bs-dismiss="modal">Close</button>
				<button type="button" id="edit_btn" class="btn btn-success">EDIT</button>
			</div>
		</div>
	</div>
</div>

<!-- end profile modal -->

<!-- start post modal -->

<!-- Button trigger modal -->
<!-- Modal -->
<div class="modal fade" id="postmodal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Do a post</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form id="add-post-form" action="AddPostServlet" method="post"
				enctype="multipart/form-data">
				<div class="modal-body">



					<div class="form-group mb-3">

						<select class="form-control" name="pcategory" required="required">

							<option selected="selected" disabled="disabled">--
								select categories --</option>
							<%
							PostDao pdao = new PostDao(ConnectionProvider.getConnection());
							List<Categories> list = pdao.getCategoryList();
							for (Categories c : list) {
							%>
							<option value="<%=c.getCid()%>"><%=c.getCname()%></option>
							<%
							}
							%>
						</select>

					</div>

					<div class="form-group mb-3">
						<input type="text" name="ptitle" class="form-control"
							placeholder="Post title" required="required" />
					</div>

					<div class="form-group mb-3">
						<textarea rows="5" id="pcontent" onfocus="enabledTabKey(this)"
							name="pcontent" class="form-control" placeholder="Post content"
							required="required"></textarea>
					</div>

					<div class="form-group mb-3">
						<textarea rows="5" id="pcode" onfocus="enabledTabKey(this)"
							name="pcode" class="form-control" placeholder="Post code"></textarea>
					</div>

					<div class="form-group">
						<label class="form-label">Choose image :</label> <input
							type="file" name="pimage" class="form-control"
							required="required" />
					</div>

				</div>

				<div class="text-center mb-2">
					<span id="spostloader" class="fa fa-refresh fa-spin fa-2x"
						style="font-size: 1.5rem; display: none;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="spostbtn" type="submit" class="btn btn-primary">Post</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- End post modal -->
<%
}
%>


