<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oops! Something Went Wrong</title>
    <%@ include file="includes/links.jsp" %> <!-- Bootstrap and icons -->
    <style>
        .error-icon {
            font-size: 80px;
            color: #dc3545;
            animation: bounce 1.5s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-20px);
            }
            60% {
                transform: translateY(-10px);
            }
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
    <div class="text-center">
        <div class="error-icon mb-3">
            <i class="ri-error-warning-line"></i>
        </div>

        <h1 class="text-danger fw-bold">Oops! Something Went Wrong</h1>
        <p class="text-secondary fs-5">
            <%= exception != null ? exception.getMessage() : "An unexpected error occurred. Please try again later." %>
        </p>

        <div class="alert alert-warning mx-auto w-75" role="alert">
            <strong>Possible Solutions:</strong>
            <ul class="text-start">
                <li>Check your internet connection.</li>
                <li>Refresh the page and try again.</li>
                <li>Ensure that the URL is correct.</li>
                <li>Contact support if the issue persists.</li>
            </ul>
        </div>

        <div class="mt-3">
            <a href="<%=application.getContextPath()%>/index" class="btn btn-danger me-2">
                <i class="ri-arrow-go-back-line"></i> Retry
            </a>
            <a href="<%=application.getContextPath()%>/index" class="btn btn-secondary me-2">
                <i class="ri-home-4-line"></i> Go Home
            </a>
            <a href="contact.jsp" class="btn btn-outline-primary disabled" >
                <i class="ri-mail-line"></i> Report Issue
            </a>
        </div>

        <% if (exception != null) { %>
        <details class="mt-4">
            <summary class="text-secondary">View Error Details</summary>
            <pre class="text-start bg-white border rounded p-3 mt-2 text-danger">
                <%= exception.toString() %>
            </pre>
        </details>
        <% } %>
    </div>
</body>

</html>
