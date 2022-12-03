<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        UserEJB u = null;
        String apres="facture/syntheseEvp.jsp";
        String lien= null;
        String datyInf = null;
        String datySup = null;
        facture.SyntheseEVP se[] = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
         datyInf = request.getParameter("mois");
         datySup = request.getParameter("annee");
         if ((datyInf == null)|| datyInf.compareTo("")==0) datyInf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
se = u.findSyntheseEVPMois(datyInf,datySup);

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<title>Trafic EVP</title><h1>Trafic EVP : mois de <%=Utilitaire.nbToMois(Utilitaire.stringToInt(datyInf))%> de l'ann&eacute;e <%=datySup%></h1>
<p align="center" class="remarque"><br>
</p>
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center">
<tr>
    <td> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="96" height="25" align="center" valign="middle">Date </td>
          <td width="193" align="center" valign="middle">Quarante pied</td>
          <td width="191" align="center" valign="middle">Vingt pied</td>
          <td><div align="center">EVP</div></td>
        </tr>
     <%
  for(int i=0;i<se.length;i++){
  %>
        <tr>
          <td width="96" height="25" align="center" valign="middle"><%=Utilitaire.formatterDaty(se[i].getDaty())%></td>
          <td width="193" align="center" valign="middle"><%=se[i].getQuarante()%></td>
          <td width="191" align="center" valign="middle"><%=se[i].getVingt()%></td>
          <td width="116" align="center" valign="middle"><%=se[i].getEVP()%></td>
        </tr>
        <%
  }
  %>
      </table></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr>
<td height="25"><b>Nombre de r&eacute;sultat :</b> <%=se.length%></td><td align="right"><b>Total :</b> <%=facture.AdminSyntheseEVP.getSommeEVP(se)%></td></tr>

</table>

