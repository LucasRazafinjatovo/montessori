<%@page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,javax.servlet.http.*,java.lang.*,java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.DiskFileUpload" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%
boolean isMultipart = FileUpload.isMultipartContent(request);
if(!isMultipart){
//request.setAttribute("msg", "Request was not multipart!");
//request.getRequestDispatcher("msg.jsp").forward(request, response);
//return;
}

DiskFileUpload upload = new DiskFileUpload();
List items = upload.parseRequest(request);
Iterator itr = items.iterator();

while(itr.hasNext()){
FileItem item = (FileItem) itr.next();
if(item.isFormField()) {
        String fieldName = item.getFieldName();
        if(fieldName.equals("name"))
        request.setAttribute("msg", "Thank You: " + item.getString());
} else {
        File fullFile = new File(item.getName());
        File savedFile = new File(getServletContext().getRealPath("/")+"/tmp/", fullFile.getName());
        item.write(savedFile);
}
}
%>
<html>
<head><title>Test upload Fichier</title></head>
<body>
<form name="myForm" action="upload.jsp" method="post" enctype="multipart/form-data">
Nom <input type="text" name="mom"/><br/>
Photo <input type="file" name="photo"/>
<input type="submit" value="valider">
</form>
</body>
</html>
