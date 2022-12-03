<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
	UserEJB u = null;
	String acte = null;
	String lien = null;
	String bute = null;
        ClassMAPTable t=null;
        String classe = null;
%>
<%
	acte = request.getParameter("acte");
        bute = request.getParameter("bute");
        classe = request.getParameter("classe");
	try
	{
		lien=(String)session.getValue("lien");
		u=(UserEJB)session.getAttribute("u");

		if (acte.compareTo("modifier")==0)
		{
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=request.getParameter("id")%>");
                </script>
                <%
                }
                if (acte.compareTo("update")==0)
                {
                  t=(ClassMAPTable)(Class.forName(classe).newInstance());
                  Page p=new Page(t,request);
                  ClassMAPTable f=p.getObjectAvecValeur();
                  u.updateObject(f);
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=request.getParameter("id")%>");
                </script>
                <%
                }
	}catch (Exception e){
	%>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%
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
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>