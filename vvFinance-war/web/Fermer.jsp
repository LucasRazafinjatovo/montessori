<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	//MapUtilisateur user=(MapUtilisateur)session.getValue("user");
	try
	{
          if (session.getAttribute("u")!=null)
          {
            UserEJB u=(UserEJB)session.getAttribute("u");
            u.ejbRemove();
            session.removeAttribute("u");
            System.out.println("lien==avantremove========="+session.getAttribute("lien"));
            session.removeAttribute("lien");
            System.out.println("lien==apresremove========="+session.getAttribute("lien"));
            session.removeAttribute("dir");
            session.removeAttribute("dirlib");
            System.out.println(session.getAttribute("u"));
          }
          //session.removeValue("lien");
        %>
	<script language='JavaScript'>window.close();</script>
<%
	}
	catch (Exception e)
	{
		out.println("<script language='JavaScript'> document.location.replace('erreur.jsp?message="+e.getMessage()+"'); </script>");
		return;
	}
%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"><font size="2" face="Geneva, Arial, Helvetica, sans-serif">Vous
        &ecirc;tes maintenant d&eacute;connect&eacute; du syst&egrave;me, si vous
        voulez retourner, il va falloir vous <a href="modele.jsp?but=index.jsp">logger</a>.
        Merci</font></div>
      <ul>
      </ul>
</td>
  </tr>
</table>
<font size="2" face="Geneva, Arial, Helvetica, sans-serif"></font>
</body>
</html>
