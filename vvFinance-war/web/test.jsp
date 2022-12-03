<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
%>
<%
try{
  UserEJBClient uc=new UserEJBClient();
UserEJB u=null;
u=uc.getInterface();
u.testLogin("dev","ved123");

u.deleteObject();
out.print("hahah");
}
catch(Exception e)
{
  out.print(e.getMessage());
  e.printStackTrace();
}
%>

