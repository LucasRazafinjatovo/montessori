<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        MapRoles mr[] = null;
        UserEJB u = null;

%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
mr = u.findRole("%");
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<%=mr[0].getIdRole()%>
<%=mr[0].getDescRole()%>
<h2>Liste des profils</h2>

