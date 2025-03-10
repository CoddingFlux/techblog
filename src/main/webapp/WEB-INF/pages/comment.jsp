<%@page import="com.techblog.dao.UserDao"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entitties.User"%>
<%@page import="com.techblog.entitties.Comment"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.CommentDao"%>

<%
// Validate post ID
String pid = request.getParameter("pid");
if (pid == null || pid.trim().isEmpty()) {
	out.println("<p style='color: red;'>Error: Post ID is missing!</p>");
	return;
}

// Validate logged-in user
User loggedInUser = (User) session.getAttribute("user");
if (loggedInUser == null) {
	out.println("<p style='color: red;'>Error: User is not logged in!</p>");
	return;
}

// Fetch comments from the database
CommentDao codao = new CommentDao(ConnectionProvider.getConnection());
List<Comment> colist = codao.getCommentMsgByPid(Long.parseLong(pid));

// Get current time as a Timestamp
Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

// Iterate over each comment
for (Comment list : colist) {
	Timestamp commentTimestamp = list.getTime();

	// Calculate time difference
	long diffInMillis = currentTimestamp.getTime() - commentTimestamp.getTime();
	long diffInMinutes = TimeUnit.MILLISECONDS.toMinutes(diffInMillis);
	long diffInHours = TimeUnit.MILLISECONDS.toHours(diffInMillis);
	long diffInDays = TimeUnit.MILLISECONDS.toDays(diffInMillis);
	long diffInYears = diffInDays / 365;

	// Determine the time format
	String timeAgo = diffInMinutes < 1 ? "Just now"
	: diffInHours < 1 ? diffInMinutes + "m ago"
			: diffInDays < 1 ? diffInHours + "h ago"
					: diffInDays < 7 ? diffInDays + "d ago"
							: diffInDays < 365 ? diffInDays + " days ago" : diffInYears + " years ago";

	UserDao userdao = new UserDao(ConnectionProvider.getConnection());

	User userval = userdao.getUserByUid(list.getUid());

	// Check if the comment belongs to the logged-in user
	boolean isLoggedInUser = list.getUid() == loggedInUser.getuId();
%>

<!-- Comment Section -->
<div
	class="d-flex mb-2 align-items-start <%=isLoggedInUser ? "" : "justify-content-start"%>">
	<%
	if (isLoggedInUser) {
	%>
	<!-- Logged-In User Comment (Left Side) -->
	<div class="flex-grow-1 text-start">
		<div class="d-flex align-items-start">

			<%
							String climage = (!loggedInUser.getuProfile().contains("https")) ? "assets/pics/"+loggedInUser.getuProfile() : loggedInUser.getuProfile();
						%>

			<img src="<%=climage%>" class="profile-img me-2 rounded-circle"
				alt="User" style="width: 40px; height: 40px;">
			<div class="flex-grow-1">
				<div class="comment-box border rounded p-2 bg-light">
					<p style="font-size: 0.9rem; font-weight: 700;"><%=loggedInUser.getuName()%></p>
					<pre class="mb-1 text-break"
						style="font-size: 0.8rem; white-space: pre-wrap; overflow-wrap: break-word; max-width: 500px;"><%=list.getComessage().trim()%></pre>
				</div>
				<div class="comment-actions mt-1">
					<a href="#" class="text-decoration-none me-2">Like</a> <a href="#"
						class="text-decoration-none me-2">Reply</a> <span
						class="text-muted" style="font-size: 0.75rem;"><%=timeAgo%></span>
				</div>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<!-- Other User Comment (Right Side) -->

	<div class="flex-grow-1 text-end">
		<div class="comment-box border rounded p-2 bg-light"
			style="display: inline-block;">
			<p style="font-size: 0.9rem; font-weight: 700;"><%=userval.getuName()%></p>
			<pre class="mb-1 text-break"
				style="font-size: 0.8rem; white-space: pre-wrap; overflow-wrap: break-word; max-width: 500px;"><%=list.getComessage()%></pre>
		</div>
		<div class="comment-actions mt-1">
			<a href="#" class="text-decoration-none me-2">Like</a> <a href="#"
				class="text-decoration-none me-2">Reply</a> <span class="text-muted"
				style="font-size: 0.75rem;"><%=timeAgo%></span>
		</div>
	</div>
	<%
							String climage1 = (!userval.getuProfile().contains("https")) ? "assets/pics/"+userval.getuProfile() : userval.getuProfile();
						%>
	<img src="<%=climage1%>" class="profile-img ms-2 rounded-circle"
		alt="User" style="width: 40px; height: 40px;">
	<%
	}
	%>
</div>

<%
    } // End of for loop
%>