<%@page import="com.techblog.entitties.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="error" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style type="text/css">
body {
	background-image: url("assets/images/pbackground.jpg");
	background-attachment: fixed;
	background-repeat: no-repeat;
	background-size: cover;
}
</style>

<%@ include file="includes/links.jsp"%>
</head>
<body>

	<%@ include file="includes/nav.jsp"%>

	<main>

		<div class="container">
			<div class="row">

				<div class="col-sm-4">

					<div class="list-group text-center mt-3">
						<button type="button" onclick="loadPost(0,this)"
							class="c-link list-group-item list-group-item-action active"
							aria-current="true">All Categories</button>
						<%
						PostDao pdao =new PostDao(ConnectionProvider.getConnection());
											List<Categories> list=pdao.getCategoryList();
											
											for(Categories c : list){
						%>

						<button type="button" onclick="loadPost(<%= c.getCid() %>,this)"
							class="c-link list-group-item list-group-item-action transi"><%= c.getCname() %></button>
						<%
							}
							%>
					</div>
				</div>

				<div class="col-sm-8 mt-3">

					<div class="container-fluid">

						<div id="postLoader" class="loader text-center">

							<span class="fa fa-refresh fa-spin fa-2x"></span>

						</div>


						<div id="postContent"
							class="row postcontent justify-content-start"></div>


					</div>

				</div>
			</div>
		</div>
	</main>
<%@ include file="includes/footer.jsp"%>
	<%@ include file="includes/scripts.jsp"%>
</body>
</html>