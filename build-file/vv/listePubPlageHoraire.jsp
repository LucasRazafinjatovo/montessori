<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
  //Etudiant e=new Etudiant();
  PubPlageHoraire a=new PubPlageHoraire();
//  a.setNomTable("MOISPRODUCTION_LIBELLE");
  String listeCrt[]={"id", "DESIGNATION","NUMERO","HEURE_DEBUT", "HEURE_FIN"};
  String listeInt[]={"HEURE_DEBUT","HEURE_FIN"};
  PageRecherche pr=new PageRecherche(a,request,listeCrt,listeInt,2);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("listePubPlageHoraire.jsp");
  String libEntete[]={"id","DESIGNATION","NUMERO","HEURE_DEBUT","HEURE_FIN"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
PubPlageHoraire []listeP=(PubPlageHoraire [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste Pub plage horaire</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listePubPlageHoraire.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listePubPlageHoraire" id="listePubPlageHoraire">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=indicateur/apreschoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=14% align="center" valign="top">Designation</td>
<td width=14% align="center" valign="top">Numero</td>
<td width=14% align="center" valign="top">Heure debut</td>
<td width=14% align="center" valign="top">Heure fin</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getDesignation()%></td>
<td align=center><%=listeP[i].getNumero()%></td>
<td align=center><%=listeP[i].getHeure_debut()%></td>
<td align=center><%=listeP[i].getHeure_fin()%></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
