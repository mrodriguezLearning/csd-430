<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String pageTitle = "My First JSP Page";
	String message = "Welcome to my first JavaServer Pages (JSP) page.";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><%= pageTitle %></title>
</head>
<body>
	<main>
		<h1><%= pageTitle %></h1>
		<p><%= message %></p>
	</main>
</body>
</html>