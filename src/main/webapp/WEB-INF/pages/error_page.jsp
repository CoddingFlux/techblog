<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sorry! Something went wrong</title>
<%@ include file="includes/links.jsp"%>
<!-- Include Bootstrap CSS here -->
</head>
<body
	class="d-flex align-items-center justify-content-center vh-100 bg-light">
	<div class="text-center">
		<img src="./assets/images/error.png" alt="Error"
			class="img-fluid mb-3" style="max-width: 300px;">
		<h1 class="text-danger">Sorry! ,Something Went Wrong...</h1>
	</div>
</body>
</html>
