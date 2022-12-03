<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="restriction.*" %>
<%@ page import="historique.*" %>
<%
  ListeTable e=new ListeTable();

e.setNomTable("listetable");
String listeCrt[]={"nom","remarque"};
String listeInt[]=null;
String libEntete[]={"id","nom","remarque"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,1,libEntete,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("utilisateur/listeTable.jsp");

pr.creerObjetPage(libEntete);
ListeTable []listeP=(ListeTable [])pr.getRs().getResultat();//liste listeEtudiant
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des tables</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeTableChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listetablechoix" id="listetablechoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=utilisateur/ficheTable.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=10% align="center" valign="top">id</td>
<td width=10% align="center" valign="top">id</td>
<td width=50% align=center valign=top>nomTable</td>
<td width=30% align=center valign=top>remarque</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getRemarque() %></td>
</tr>
<%}%>
</table>

</form>


<%
//out.println(pr.getBasPage());
%>
