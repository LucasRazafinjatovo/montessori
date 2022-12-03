<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Caisse caiss[] = null;
		String etatCaisse=null;
		historique.MapUtilisateur ut=null;

%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
caiss = u.findCaisse("%","%","%","%");
 ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des caisses enregistr&eacute;es</h1>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
    <td width="150" height="19" valign="top"><strong>Caisse</strong></td>
    <td width="150" valign="top"><strong>Responsable</strong></td>
	 <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
    <td width="69" align="center" valign="top"><strong>Action</strong></td>
	<%
	}
	%>
  </tr>
  <%
	  for(int i=0;i<caiss.length;i++){
	  %>
  <tr>
    <td height="24"><%=caiss[i].getDescCaisse()%> </td>
    <td><%=caiss[i].getRespCaisse()%> </td>
	 <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("compta")==0)
		{
   %>
    <td valign="top">
		<%
			etatCaisse=caiss[i].getIdEtatCaisse();
			if (etatCaisse.compareTo("etaCs1")==0)
			{
		%>
      <a href="<%=lien%>?but=finance/apresCaisse.jsp&idCaisse=<%=caiss[i].getIdCaisse()%>&acte=UPDATE&caisse=<%=caiss[i].getDescCaisse()%>&idEtat=etaCs2&responsable=<%=caiss[i].getRespCaisse()%>">Fermer</a>
      <%
			}
		%>
		<%

			if (etatCaisse.compareTo("etaCs2")==0)
			{
		%>
			 <a href="<%=lien%>?but=finance/apresCaisse.jsp&idCaisse=<%=caiss[i].getIdCaisse()%>&acte=UPDATE&caisse=<%=caiss[i].getDescCaisse()%>&idEtat=etaCs1&responsable=<%=caiss[i].getRespCaisse()%>">Ouvrir</a>
		<%
			}
		%>&nbsp;
            <a href="<%=lien%>?but=finance/updateCaisse.jsp&idCaisse=<%=caiss[i].getIdCaisse()%>">Mod</a>
          </td>
	<%
	}
	%>
    </tr>
  <%
		}
	%>
</table>
</td>
  </tr>
</table>

