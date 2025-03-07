<%@page import="com.techblog.dao.CommentDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.entitties.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entitties.User"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.techblog.helper.EncoderDecoderProvider"%>
<div class="container">
    <div class="row align-items-stretch"> <!-- Ensures equal-height columns -->
        <%
        Long cid = Long.parseLong(request.getParameter("catid"));
        User user = (User) session.getAttribute("user");
        PostDao pdao = new PostDao(ConnectionProvider.getConnection());
        LikeDao getDao = new LikeDao(ConnectionProvider.getConnection());
        CommentDao cdao=new CommentDao(ConnectionProvider.getConnection());
        List<Post> postlist = cid == 0 ? pdao.getAllPost() : pdao.getPostByCatId(cid);

        if (postlist.isEmpty()) {
            out.println("<h1 class='lead text-center text-white'>No posts in this Category...!</h1>");
            return;
        }

        for (Post pst : postlist) {
            Long pid = pst.getPid();
            boolean isliked = getDao.isPostLikedByUser(pid, user.getuId());
        %>
        <div class="col-12 col-md-6 mb-3 d-flex"> <!-- Responsive with equal height -->
            <div class="card shadow-sm flex-grow-1 d-flex flex-column"> <!-- Stretch card to full height -->
                <div class="p-1">
                    <img src="assets/blog_pics/<%=pst.getPimage()%>" 
                         class="card-img-top post-pics img-fluid w-100 p-2" 
                         alt="Post Image">
                </div>

                <div class="card-body d-flex flex-column">
                    <h4 class="card-title fs-5"><%=pst.getPtitle()%></h4>
                    <p class="card-text flex-grow-1">
                        <%=Arrays.stream(pst.getPcontent().trim().split(" "))
                        .limit(12)
                        .collect(Collectors.joining(" ")) + " ..." %>
                    </p>
                </div>

                <div class="card-footer text-muted primary-background d-flex justify-content-around flex-wrap gap-2 mt-auto">
                    <a href="#" id="allmkpostlike"
                       onclick="makePostLike(event, <%=isliked%>, <%=pid%>, <%=user.getuId()%>)"
                       class="btn btn-outline-light me-1 gap-1">
                        <i id="likedis<%=pst.getPid()%>" 
                           class="ri-thumb-up-<%=isliked ? "fill" : "line"%>"></i>
                    </a>
                    <a href="pdetail?pid=<%=EncoderDecoderProvider.encrypt(pid.toString())%>"
                       class="btn btn-outline-light me-2">Read..</a>
                    <a href="pdetail?pid=<%=EncoderDecoderProvider.encrypt(pid.toString())%>" class="btn btn-outline-light gap-1">
                        <i class="ri-chat-1-line"></i><span><%=cdao.countAllComment(pid)%></span>
                    </a>
                </div>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>
