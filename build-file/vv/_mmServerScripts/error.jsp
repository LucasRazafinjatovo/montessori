<%@ page language="java" isErrorPage="true"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<center><h2>Application Error</h2></center>

<div CLASS="errorText">
Error Message: <%= exception.getMessage() %>
</div>

</body>
</html>
