<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="penalite.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        ChiffreAffTac chiff[] = null;
        String lien = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
        historique.MapUtilisateur ut=null;
%>
<%
        pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
chiff=u.findChiffreAffTac("%","%","%","%");
  ut=u.getUser();
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Chiffre d'affaires TAC </h1>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="87" align="center" valign="middle">N&deg; Chiffre</td>
          <td width="93" height="25" align="center" valign="middle">Mois</td>
          <td width="95" align="center" valign="middle">Ann&eacute;e</td>
          <td width="222" align="center" valign="middle">Montant en Ar</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td width="103"></td>
          <%
                }
                %>
        </tr>
        <%
int pejy=0;
if(pazy==0){
        pejy=0;
        pazy=1;
}else{
        pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>chiff.length){
  pazy2=chiff.length;
}
%>
        <%
  for(int i=pazy1;i<pazy2;i++){

  %>
        <tr>
          <td width="87" align="center" valign="middle"><%=chiff[i].getIdChiffre()%></td>
          <td width="93" height="25" align="center" valign="middle"><%=Utilitaire.nbToMois(chiff[i].getMois())%></td>
          <td width="95" align="center" valign="middle"><%=chiff[i].getAnnee()%></td>
          <td width="222" align="center" valign="middle"><%=Utilitaire.formaterAr((double)chiff[i].getMontant())%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0 || ut.getIdrole().compareTo("adminFacture")==0)
                {
   %>
          <td>
		  <a href="javascript:decision('Vous voulez vraiment annuler ce chiffre d\'affaire?\n\nCette opération supprimera définitivement l\'accident du système.','<%=lien%>?but=parametre/apresChiffreAffaire.jsp&idChiffre=<%=chiff[i].getIdChiffre()%>&acte=DELETE')">
		  Annuler</a></div></td>
          <%
                }
                %>
        </tr>
        <%
}
%>
      </table>

</td></tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat : </b><%=chiff.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%if(chiff.length%nbParPazy==0)out.println(chiff.length/nbParPazy);else out.println(chiff.length/nbParPazy+1);%> </td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=parametre/listeChiffreAffaireTac.jsp&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(chiff.length>pazy2){
      %>
      <a href="<%=lien%>?but=parametre/listeChiffreAffaireTac.jsp&pazy=<%=pazy%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>
