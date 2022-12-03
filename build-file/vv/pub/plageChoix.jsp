<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="facture.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.OpLcComplet" %>
<script type="text/javascript">
function checkBoxer(obj,taille)
{
     if(obj.checked==true)
     {
         for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = true;
         }
     }
     else
     {
       for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = false;
         }
     }
}
</script>
<%
PubPlageHoraire p = new PubPlageHoraire();
String listeCrt[] = {"id","designation","numero","heure_debut","heure_fin"};
String listeInt[] = null;
String libEntete[] = {"id","designation","numero","heure_debut","heure_fin"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("plageChoix.jsp");
pr.getFormu().getChamp("heure_debut").setLibelleAffiche("Heure debut");
pr.getFormu().getChamp("heure_fin").setLibelleAffiche("Heure fin");
String colSomme[] = null;
pr.creerObjetPageMultiple(libEntete,colSomme);
PubPlageHoraire[] listeP = (PubPlageHoraire[])pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste plage horaire </h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="plageChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td align="center" valign="top"></td>
<td align="center" valign="top">ID</td>
<td align="center" valign="top">Designation</td>
<td align="center" valign="top">Numero</td>
<td align="center" valign="top">Heure debut</td>
<td align="center" valign="top">Heure fin</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId()%></td>
<td align=center><%=listeP[i].getDesignation()%></td>
<td align=center><%=listeP[i].getNumero()%></td>
<td align=center><%=listeP[i].getHeure_debut()%></td>
<td align=center><%=listeP[i].getHeure_fin()%></td>
</tr>
<%}%>listeP
</table>
</form>


<%
//out.println(pr.getBasPagee(request.getParameter("champReturn")));
%>
