<!DOCTYPE html>
<%@page import="com.techblog.helper.EncoderDecoderProvider"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.techblog.entitties.Post"%>
<%@ page errorPage="error" %>
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
		<div class="bg-light p-5 rounded primary-background">
			<div class="container-md text-white pb-5">
				<h1 class="display-4">Welcome to TechSphere - Explore the World
					of Technology!</h1>
				<p class="lead"></p>

				<p class="lead lh-2">Dive into the latest trends, insights, and
					tutorials in the world of technology. Whether you're a beginner
					looking to learn coding, a developer seeking advanced concepts, or
					a tech enthusiast exploring new innovations, our blogs are here to
					guide you. From web development and programming languages to
					databases and frameworks, we cover it all with practical examples
					and expert tips. Stay curious, stay informed - let's build the
					future together!</p>


				<a href="register" class="btn btn-outline-light me-2 mb-3 mt-3"><span><i
						class="ri-user-smile-line"></i></span> Start ! its Free</a> <a href="login"
					class="btn btn-outline-light mb-3 mt-3"><span><i
						class="ri-login-circle-line"></i></span> Login</a>
			</div>
		</div>
	</div>

	<!-- /banner -->


	<div class="container mt-5">
		<div class="row align-items-stretch justify-content-center">
			<!-- Use align-items-stretch to make cards equal height -->
			<%
        PostDao pdao = new PostDao(ConnectionProvider.getConnection());
        List<Post> toppost = pdao.getTopPosts();
        for (Post list : toppost) {
        %>
			<div class="col-12 col-md-6 col-lg-3 mb-3 d-flex">
				<!-- Use d-flex for equal height -->
				<div class="card shadow flex-grow-1">
					<!-- flex-grow-1 ensures cards fill height -->
					<div class="card-body d-flex flex-column">
						<h5 class="card-title"><%=list.getPtitle()%></h5>
						<p class="card-text flex-grow-1"><%=Arrays.stream(list.getPcontent().trim().split(" ")).limit(12).collect(Collectors.joining(" ")) + " ..." %></p>
						<a
							href="pdetail?pid=<%=EncoderDecoderProvider.encrypt(list.getPid().toString())%>"
							class="btn primary-background text-white mt-auto">Read more</a>
						<!-- mt-auto pushes button to bottom -->
					</div>
				</div>
			</div>
			<%
        }
        %>
		</div>
	</div>


	<!-- <div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>

			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>

			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>
		</div>

		<div class="row align-items-start">
			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>

			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>

			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div>

			<div class="col-12 col-md-3 mb-3">
				<div class="card shadow">
					<div class="card-body">
						<h5 class="card-title">Python Programming</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="" class="btn primary-background text-white">Read more</a>
					</div>
				</div>
			</div> -->
	</div>
	</div>
	<%@ include file="includes/footer.jsp"%>
	<%@ include file="includes/scripts.jsp"%>
</body>
</html>
