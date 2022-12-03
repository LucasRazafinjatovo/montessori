<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
UserEJB u = null;
String acte=null;
String lien=null;
String rep=null;
String idUser=null;
%>
<%
try
{

acte=request.getParameter("acte");
lien=(String)session.getAttribute("lien");
u=(UserEJB)session.getAttribute("u");
idUser=request.getParameter("idUser");
System.out.println("idUser="+idUser);
if (acte.compareTo("UPDATE")==0)
{
    
   rep=u.updateUtilisateurs(idUser,request.getParameter("login"),request.getParameter("newPass"),request.getParameter("nom"),request.getParameter("adresse"),request.getParameter("telephone"),request.getParameter("idRole"));
  %>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/detailUtilisateurPerso.jsp"); </script>
<%
}
}
catch (Exception e)
{%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
return;
}
%>


