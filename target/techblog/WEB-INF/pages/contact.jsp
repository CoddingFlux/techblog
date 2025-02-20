<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us - TechSphere</title>
<!-- Bootstrap CSS -->
<%@ include file="includes/links.jsp"%>
</head>
<body>

	<%@ include file="includes/nav.jsp"%>

	<!-- Contact Page Banner -->
	<div
		class="container-fluid banner-clip-path primary-background text-white text-center py-5">
		<h1>Contact Us</h1>
		<p>Have questions or suggestions? We’d love to hear from you!</p>
	</div>

	<!-- Contact Form Section -->
	<div class="container mt-5">
		<div class="row">
			<!-- Contact Form -->
			<div class="col-md-6">
				<h3>Send Us a Message</h3>
				<form action="ContactServlet" method="post">
					<div class="mb-3">
						<label for="name" class="form-label">Your Name</label> <input
							type="text" class="form-control" id="name" name="name" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">Your Email</label> <input
							type="email" class="form-control" id="email" name="email"
							required>
					</div>
					<div class="mb-3">
						<label for="subject" class="form-label">Subject</label> <input
							type="text" class="form-control" id="subject" name="subject"
							required>
					</div>
					<div class="mb-3">
						<label for="message" class="form-label">Message</label>
						<textarea class="form-control" id="message" name="message"
							rows="5" required></textarea>
					</div>
					<button type="submit" class="btn primary-background text-white">Send
						Message</button>
				</form>
			</div>

			<!-- Contact Info & Social Links -->
			<div class="col-md-6">
				<h3>Get in Touch</h3>
				<p>Email: support@techblog.com</p>
				<p>Phone: +123 456 7890</p>
				<p>Address: Tech Street, Silicon Valley, CA</p>

				<!-- Social Media Links -->
				<div class="mt-4">
					<a href="#" class="btn btn-outline-primary me-2">Facebook</a> <a
						href="#" class="btn btn-outline-info me-2">Twitter</a> <a href="#"
						class="btn btn-outline-danger">Instagram</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Optional Google Maps Embed -->
	<div class="container mt-5 contamap">
		<iframe
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d235014.29919250146!2d72.41492758119553!3d23.020158081903805!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395e848aba5bd449%3A0x4fcedd11614f6516!2sAhmedabad%2C%20Gujarat!5e0!3m2!1sen!2sin!4v1740083514272!5m2!1sen!2sin"
			width="100%" height="350" style="border: 0;" allowfullscreen=""
			loading="lazy"></iframe>
	</div>


	<%@ include file="includes/footer.jsp"%>
	<%@ include file="includes/scripts.jsp"%>
</body>
</html>
