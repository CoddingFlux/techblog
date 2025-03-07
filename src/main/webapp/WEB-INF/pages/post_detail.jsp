<%@page import="com.techblog.dao.CommentDao"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.entitties.Post"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.EncoderDecoderProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="error"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>


<%@ include file="includes/links.jsp"%>
</head>
<body>

	<%@ include file="includes/nav.jsp"%>

	<%
	Long pid = Long.parseLong(EncoderDecoderProvider.decrypt(request.getParameter("pid")));
	User user = (User) session.getAttribute("user");
	PostDao pdao = new PostDao(ConnectionProvider.getConnection());
	Post post = pdao.getPostByPostId(pid);
	LikeDao getDao = new LikeDao(ConnectionProvider.getConnection());
	CommentDao cdao=new CommentDao(ConnectionProvider.getConnection());
	
	boolean isUserLiked = getDao.isPostLikedByUser(pid, user.getuId());
	%>

	<div class="row">
		<div class="col-md-6 offset-md-3 mt-3 mb-3">

			<div class="card p-2">

				<div class="card-header primary-background text-white ptitle">

					<%=post.getPtitle()%>

				</div>

				<img alt="" src="assets/blog_pics/<%=post.getPimage()%>"
					class="card-image-top pdetailimg" />


				<div class="card-body ">

					<div class="d-flex justify-content-between pudate">
						<%
						LocalDateTime dateTime = post.getPdate().toLocalDateTime();
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
						String formattedDate = dateTime.format(formatter);
						%>
						
						<b><%=pdao.getUserByUid(post.getUid())%> has posted</b> <b><%=formattedDate%></b>
					</div>
					<br>

					<div>
						<ul>
							<%
							String content = post.getPcontent(); // Get post content
							String[] sentences = content.split("\\."); // Split by period

							for (String sentence : sentences) {
								if (!sentence.trim().isEmpty()) { // Ignore empty lines
							%>
							<li class="mb-2"><%=sentence.trim()%></li>
							<%
							}
							}
							%>
						</ul>
					</div>

					<div class="code-container">
						<div class="code-editor">
							<div class="line-numbers">
								<%
								String code = post.getPcode(); // Get code content
								String[] lines = code.split("\n"); // Split by lines
								for (int i = 1; i <= lines.length; i++) {
								%>
								<div class="line-number"><%=i%></div>
								<%
								}
								%>
							</div>
							<%
							pageContext.setAttribute("pcode", post.getPcode());
							%>
							<pre class="code-content">${fn:escapeXml(pcode)}</pre>
						</div>
					</div>



				</div>

				<div
					class="card-footer text-muted primary-background d-flex justify-content-between">
					<div>
						<a href="#" id="mkpostlike"
							onclick="makePostLike(event,<%=isUserLiked%>,<%=pid%>,<%=user.getuId()%>)"
							class="btn btn-outline-light"> <i id="likedis"
							class="ri-thumb-up-<%=isUserLiked ? "fill" : "line"%>"></i> <!-- <i id="dislike" class="ri-thumb-up-line"></i>  -->
						</a> <a href="" id="commentmsgcollapse"
							onclick="toggleChatBox(event),loadComments(<%=pid%>)"
							class="btn btn-outline-light"> <i class="ri-chat-1-line"></i>
							<span id="cocounter"><%=cdao.countAllComment(pid)%></span>
						</a>
					</div>

					<div>
						<a href="<%=application.getContextPath()%>/posts"
							class="btn btn-outline-light"><i
							class="fa fa-angle-double-left"></i> Back</a>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div class="row" id="msgbox" style="display: none;">
		<div class="col-md-6 offset-md-3 mt-3 mb-3">
			<div class="comment-section p-3">

				<div class="primary-background p-2 text-white rounded">
					<h5>Comments</h5>
				</div>

				<div class="my-3"
					style="height: 300px; width: auto; overflow: auto;">
					<div id="msgcontent"></div>
				</div>

				<!-- Comment Input -->
				<div class="d-flex align-items-center my-3 position-relative">
					
					<img src="assets/pics/<%=user.getuProfile()%>" class="profile-img me-2"
						alt="User">
					<div class="input-group flex-grow-1">
						<textarea id="msgcomm" class="form-control"
							placeholder="Write a comment..." rows="1"
							style="padding-right: 50px; font-size: 0.8rem; resize: none; overflow-y: hidden; max-height: 120px;"></textarea>
						<a href="#"
							onclick="sendComment(event,<%=pid%>,<%=user.getuId()%>),loadComments(<%=pid%>)"
							class="position-absolute end-0 top-50 translate-middle-y me-2"
							style="z-index: 5;"> <i class="fa fa-send-o send"></i>
						</a>
					</div>
				</div>

			</div>
		</div>
	</div>

	<%@ include file="includes/footer.jsp"%>
	<%@ include file="includes/scripts.jsp"%>

</body>
</html>