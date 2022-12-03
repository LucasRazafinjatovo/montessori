<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        UserEJB u = null;
        Societe[] spat = null;
        String id=null;

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
spat = u.findMaSocieteTab("%","%","%","%","%","%","%","%","%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Information Soci&eacute;t&eacute;.</h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
    <td width="100" valign="top"><div align="center" class="entete">Nom</div></td>
    <td width="160" valign="top"><div align="center" class="entete">NumStat</div></td>
    <td width="100" valign="top"><div align="center" class="entete">Logo</div></td>
    <td width="90" valign="top"><div align="center" class="entete">Nif</div></td>
    <td width="120" valign="top"><div align="center" class="entete">Entité</div></td>
    <td width="120" valign="top"><div align="center" class="entete">Action</div></td>
  </tr>
<%
           for(int i=0;i<spat.length;i++)
    {
    %>
  <tr >
    <td width="183" valign="top"><div align="center"><a href="<%=lien%>?but=listeInfoSpat.jsp&id=<%=spat[i].getIdSpat()%>"><%=spat[i].getNom()%></a></div></td>
    <td valign="top"><div align="center"><%=spat[i].getNumStat()%></div></td>
    <td valign="top"><div align="center"><%=spat[i].getLogo()%>&nbsp;</div></td>
    <td valign="top"><div align="center"><%=spat[i].getNif()%></div></td>
    <td valign="top"><div align="center"><%=u.findTypeObjet("beneficiaire",spat[i].getEntite(),"%")[0].getDesce()%></div></td>
    <td width="183" valign="top"><div align="center"><a href="<%=lien%>?but=listeInfoSpat.jsp&id=<%=spat[i].getIdSpat()%>">Details</a>&nbsp;<a href="<%=lien%>?but=infoSpat.jsp&id=<%=spat[i].getIdSpat()%>">Modifier</a></div></td>
  </tr>
<%
}
    %>
</table>
</td></tr></table>
