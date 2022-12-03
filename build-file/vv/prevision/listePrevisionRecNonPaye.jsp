<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%

PrevisionDepense e = new PrevisionDepense();
String etat = "PREVRECETTEVISENONPAYE";
e.setNomTable(etat);
String listeCrt[] = {"daty","montant","description","id"};
String listeInt[] = {"daty","montant"};
String libEntete[] = {"id","daty","description","montantinit", "montant"};

PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionRecNonPaye.jsp");
String[]colSomme = {"montantinit", "montant"};
pr.creerObjetPage(libEntete,colSomme);
pr.setNpp(300);
PrevisionDepense []listeP=(PrevisionDepense [])pr.getRs().getResultat();
%>
<h1>Liste pr&eacute;visions d&eacute;penses non pay&eacute;</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionRecNonPaye.jsp" method="post" name="listePrevisionDetail" id="listePrevisionDetail">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[] = {pr.getLien()+"?but=prevision/fichePrevisionRecDetail.jsp"};
String colonneLien[] = {"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form name="mep" action="<%=pr.getLien() %>?but=prevision/apresPrevision.jsp" method="post">
<input type="hidden" name="acte" value="reporter">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=20% align=center valign=top>daty</td>
<td width=10% align=center valign=top>description</td>
<td width=10% align=center valign=top>montantinit</td>
<td width=25% align=center valign=top>montant</td>
<td width=28% align=center valign=top>date report</td>
<td width=10% align=center valign=top>supprimer</td>
</tr>
<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><a href="<%=pr.getLien()%>?but=prevision/fichePrevisionRecDetail.jsp&id=<%=listeP[i].getId()%>"><%=listeP[i].getId() %></a></td>
<td align=center><%=Utilitaire.datetostring(listeP[i].getDaty()) %></td>
<td align=center><%=listeP[i].getDescription()  %></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontantinit()) %></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontant()) %></td>
<td align=center><input type="text" name="page<%=i%>" value=<%=Utilitaire.datetostring(listeP[i].getDaty()) %> ></td>
<td align=center><a href="<%=pr.getLien()+"?but=prevision/apresPrevision.jsp&acte=delete&numObjet="+listeP[i].getId()+"&crt="+pr.getFormu().getListeCritereString()+"&numPage="+pr.getNumPage()+"&classe=PrevisionRecette"%>">X</a></td>
</tr>
<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">
<%}%>
</table>
<input type="hidden" name="nb" value="<%=listeP.length%>">
<input type="hidden" name="bute" value="prevision/listePrevisionRecNonPaye.jsp">
<input type="hidden" name="classe" value="PrevisionRecette">
<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">
<input type="submit" value="valider">
</form>
<%
out.println(pr.getBasPage());
%>
