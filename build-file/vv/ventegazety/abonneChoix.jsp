<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
  AbonneComplet p = new AbonneComplet();
p.setNomTable("abonne_vue");
String listeCrt[]={"id","idcivilite", "nom","prenom", "cin", "telephone", "adresse", "idquartier","idsecteur"};
String listeInt[]=null;
  PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.getFormu().getChamp("idcivilite").setLibelle("Civilit&eacute;");
pr.getFormu().getChamp("idsecteur").setLibelle("Secteur");
pr.getFormu().getChamp("idquartier").setLibelle("Quartier");
pr.setApres("ventegazety/abonne-liste.jsp");
String libEntete[]={"id","idcivilite", "nom","prenom", "cin", "telephone", "adresse", "idquartier", "idsecteur"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);
AbonneComplet []listeP=(AbonneComplet [])pr.getRs().getResultat();//liste offre
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des abonnées</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="abonneChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
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
<td align="left" valign="top">id</td>
<td align="left" valign="top">Civilite</td>
<td align="left" valign="top">Nom</td>
<td align="left" valign="top">Prenom</td>
<td align="left" valign="top">CIN</td>
<td align="left" valign="top">Telephone</td>
<td align="left" valign="top">Adresse</td>
<td align="left" valign="top">Quartier</td>
</tr>
<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align="left"><%=listeP[i].getId() %></td>
<td align="left"><%=listeP[i].getIdcivilite() %></td>
<td align="left"><%=listeP[i].getNom() %></td>
<td align="left"><%=listeP[i].getPrenom() %></td>
<td align="left"><%=listeP[i].getCin() %></td>
<td align="left"><%=listeP[i].getTelephone() %></td>
<td align="left"><%=listeP[i].getAdresse() %></td>
<td align="left"><%=listeP[i].getIdquartier() %></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
