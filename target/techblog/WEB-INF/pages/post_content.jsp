<%@page import="java.util.List"%>
<%@page import="com.techblog.entitties.User"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.helper.EncoderDecoderProvider"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.techblog.entitties.Post"%>
<%@page import="com.techblog.entitties.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Long cid = Long.parseLong(request.getParameter("catid"));
User user = (User) session.getAttribute("user");
PostDao pdao = new PostDao(ConnectionProvider.getConnection());
LikeDao getDao = new LikeDao(ConnectionProvider.getConnection());
List<Post> postlist = new ArrayList<Post>();

if (cid == 0) {
	postlist = pdao.getAllPost();
} else {
	postlist = pdao.getPostByCatId(cid);
}

if (postlist.size() == 0) {
	out.println("<h1 class='lead text-center text-white'>No post in this Category...!</h1>");
	return;
}

for (Post pst : postlist) {
	Long pid = pst.getPid();
	boolean isliked = getDao.isPostLikedByUser(pid, user.getuId());
%>

<div class="col-12 col-md-6 mb-3">
	<div class="card shadow-sm">
		<div class="p-1">
			<img src="assets/blog_pics/<%=pst.getPimage()%>"
				class="card-img-top post-pics img-fluid w-100 p-2" alt="Post Image">
		</div>

		<div class="card-body">
			<h4 class="card-title fs-5"><%=pst.getPtitle()%></h4>
			<p class="card-text"><%=Arrays.stream(pst.getPcontent().trim().split(" ")).limit(12).collect(Collectors.joining(" ")) + " ..."%></p>
		</div>
		<div
			class="card-footer text-muted primary-background d-flex justify-content-around flex-wrap gap-2">
			<a href="#" id="allmkpostlike"
				onclick="makePostLike(event,<%=isliked%>,<%=pid%>,<%=user.getuId()%>)"
				class="btn btn-outline-light me-1 gap-1"><i
				id="likedis<%=pst.getPid()%>"
				class="ri-thumb-up-<%=isliked ? "fill" : "line"%>"></i></a> <a
				href="pdetail?pid=<%=EncoderDecoderProvider.encrypt(pid.toString())%>"
				class="btn btn-outline-light me-2">Read..</a> <a href="#"
				class="btn btn-outline-light gap-1"><i class="ri-chat-1-line"></i><span>10</span></a>
		</div>
	</div>
</div>

<%
}
%>