<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
  ParametreBase e=new ParametreBase();

e.setNomTable("parametrepaier");

String listeCrt[]={"poids","dateEffectivite"};
String listeInt[]={"poids","dateEffectivite"};
String libEntete[]={"id","hauteur","largeur","poids","marge","dateEffectivite"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listeParametreChoix.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
ParametreBase []listeP=(ParametreBase [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des articles</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="pub/listeParametreChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeParametreChoix" id="listeParametreChoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/ficheParametre.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresChoixFournisseur.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=23% align=center valign=top>Hauteur</td>
<td width=14% align=center valign=top>Largeur</td>
<td width=14% align=center valign=top>Poids</td>
<td width=14% align=center valign=top>Date Effectivite</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getHauteur() %></td>
<td align=center><%=listeP[i].getLargeur() %></td>
<td align=center><%=listeP[i].getPoids()%></td>
<td align=center><%=listeP[i].getDateEffectivite()%></td>
</tr>
<%}%>
</table>
</form>

