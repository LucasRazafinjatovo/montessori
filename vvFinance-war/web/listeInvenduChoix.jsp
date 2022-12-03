<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
InvenduLibelle rv=new InvenduLibelle();
String listeCrt[]={"id","nom","place","province","parution","daty","journal"};
String listeInt[]={"daty","parution"};
String libEntete[]={"id","nom","journal","parution","daty","province","nombreinvendu"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeInvenduChoix.jsp");
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"nombreinvendu"};

pr.creerObjetPage(libEntete,colSomme);
InvenduLibelle[]listeP=(InvenduLibelle[])pr.getRs().getResultat();
//pr.preparerDataFormu();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des invedus</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeInvenduChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheInvendu.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top">id</td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align=center valign=top>nom</td>
<td width=21% align=center valign=top>journal</td>
<td width=14% align=center valign=top>parution</td>
<td width=14% align=center valign=top>daty</td>
<td width=7% align=center valign=top>province</td>
<td width=14% align=center valign=top>nombreinvendu</td>

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
<td align=center><%=listeP[i].getJournal() %></td>
<td align=center><%=listeP[i].getParution() %></td>
<td align=center><%=listeP[i].getDaty()%></td>
<td align=center><%=listeP[i].getProvince()%></td>
<td align=center><%=listeP[i].getNombreinvendu()%></td>
</tr>

<%}%>
</table>

</form>
<%
//out.println(pr.getTableau().getHtml());
//out.println(pr.getBasPage());
%>
