<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
  //Etudiant e=new Etudiant();
  MoisProduction a=new MoisProduction();
  a.setNomTable("MOISPRODUCTION_LIBELLE");
  String listeCrt[]={"id", "journal","mois","annee", "nbjrs"};
  String listeInt[]={"mois","annee", "nbjrs"};
  PageRecherche pr=new PageRecherche(a,request,listeCrt,listeInt,3);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("choixMoisproduction.jsp");
  String libEntete[]={"id","journal","mois","annee"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
MoisProduction []listeP=(MoisProduction [])pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des mois de production</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="choixMoisproduction.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../<%=pr.getLien() %>?but=indicateur/apreschoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=14% align="center" valign="top">Journal</td>
<td width=14% align="center" valign="top">Mois</td>
<td width=14% align="center" valign="top">Ann&eacute;e</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getJournal() %></td>
<td align=center><%=listeP[i].getMois() %></td>
<td align=center><%=listeP[i].getAnnee()%></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
