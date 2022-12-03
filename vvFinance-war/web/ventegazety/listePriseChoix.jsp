<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
  Prisejournallib e=new Prisejournallib();

  e.setNomTable("Prisejournallib");
  String listeCrt[]={"id","journal","numparution","vendeur","matricule","daty","nbreprise","type","province"};
  String listeInt[]={"daty"};
  PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("listePriseChoix.jsp");
  affichage.Champ[] liste=new affichage.Champ[2];
  Journal prof1=new Journal();
  prof1.setNomTable("Journal");
  liste[0]=new Liste("journal",prof1,"val","val");
  Vendeur prof2=new Vendeur();
  prof2.setNomTable("Vendeur");
  liste[1]=new Liste("vendeur",prof2,"surnom","surnom");
  pr.getFormu().changerEnChamp(liste);

  String libEntete[]={"id","journal","numparution","vendeur","matricule","daty","nbreprise","type","province"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
Prisejournallib []listeP=(Prisejournallib [])pr.getRs().getResultat();//liste listeEtudiant
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des prises</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listePriseChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/fichePrise.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align="center" valign="top">journal</td>
<td width=14% align="center" valign="top">numparution</td>
<td width=14% align="center" valign="top">vendeur</td>
<td width=14% align="center" valign="top">nombre prise</td>
<td width=14% align="center" valign="top">type</td>
<td width=14% align="center" valign="top">daty</td>
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
<td align=center><%=listeP[i].getNumparution() %></td>
<td align=center><%=listeP[i].getVendeur() %></td>
<td align=center><%=listeP[i].getNbreprise()%></td>
<td align=center><%=listeP[i].getType()%></td>
<td align=center><%=listeP[i].getDaty()%></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
