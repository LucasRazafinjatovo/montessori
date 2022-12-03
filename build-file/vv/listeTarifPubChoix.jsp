<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Montant p = new Montant();
p.setNomTable("montantvue");
String listeCrt[] = {"id","idgazety","couleur","taille","mont"};
String listeInt[] = null;
String libEntete[] = {"id","idgazety","couleur","taille","mont"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeTarifPubChoix.jsp");


String colSomme[]=null;

pr.creerObjetPage(libEntete,colSomme);
Montant []listeP=(Montant [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste tarif pub</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeTarifPubChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeTarif" id="listeTarif">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=produit/ficheClient.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=listeTarifPubChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">Id</td>
<td width=23% align=center valign=top>Journal</td>
<td width=14% align=center valign=top>Couleur</td>
<td width=14% align=center valign=top>Format</td>
<td width=14% align=center valign=top>Montant</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>



<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getIdgazety() %></td>
<td align=center><%=listeP[i].getCouleur() %></td>
<td align=center><%=listeP[i].getTaille()%></td>
<td align=center><%=listeP[i].getMont()%></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPage());
%>
