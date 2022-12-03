<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
  PrixjournalLibelle jr=new PrixjournalLibelle();
jr.setNomTable("prixjournallibelle2");
String listeCrt[]={"journal","nom","prix"};
String listeInt[]={"prix"};
  PageRecherche pr=new PageRecherche(jr,request,listeCrt,listeInt,4);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("JournalChoix.jsp");
  pr.getFormu().getChamp("prix1").setLibelleAffiche("Prix (min)");
  pr.getFormu().getChamp("prix2").setLibelleAffiche("Prix (max)");
  String libEntete[]={"id","journal","nom","prix"};
  String[]colSomme={"prix"};
pr.creerObjetPage(libEntete,colSomme);
PrixjournalLibelle []listeP=(PrixjournalLibelle [])pr.getRs().getResultat();//liste journal
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des Journaux</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="journalChoix.jsp.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align="center" valign="top">Journal</td>
<td width=14% align="center" valign="top">Nom</td>
<td width=14% align="center" valign="top">Prix</td>
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
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getPrix() %></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
