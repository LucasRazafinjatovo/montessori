<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Pucomplet p=new Pucomplet();
String listeCrt[]={"id","libClient","idCat","libAgence","designation","libJournal","numParution","pagemisyazy","datyParution"};
String listeInt[]={"numParution","pagemisyazy","datyParution"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePubRemise.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","libClient","numParution","datyParution","montantVal","libJournal"};
String colSomme[]={"montantVal"};
pr.creerObjetPage(libEntete,colSomme);
Pucomplet []listeP=(Pucomplet [])pr.getRs().getResultat();
%>
<html>
<script type="text/javascript">

function calculere(i)
{
for(c=0;c<i;c++)
{
  var ge=document.getElementsByName("page"+c)[0];
  if(mep.ensemble.value!='null' && mep.ensemble.value!='')
  {
    ge.value=mep.ensemble.value;
  }
}
}
</script>

<h1>Liste des pubicites</h1>
<form action="<%=pr.getLien()%>?but=pub/listePubRemise.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/fichePub.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form name="mep" action="<%=pr.getLien() %>?but=pub/apresListe.jsp" method="post">
<input type="submit" value="valider">
<input type="hidden" name="acte" value="remise">
<input type="text" name="ensemble" value="<%=pr.getParamSansNull("ensemble")%>" onBlur = "calculere(<%=listeP.length%>)">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=20% align=center valign=top>libClient</td>
<td width=10% align=center valign=top>numP</td>
<td width=10% align=center valign=top>journal</td>
<td width=25% align=center valign=top>montantVal</td>
<td width=28% align=center valign=top>remise</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><a href=<%=pr.getLien()%>?but=pub/fichePub.jsp&id=<%=listeP[i].getId()%>&libJournal=<%=listeP[i].getLibJournal()%>><%=listeP[i].getId() %></a></td>
<td align=center><%=listeP[i].getLibClient() %></td>
<td align=center><%=listeP[i].getNumParution() %></td>
<td align=center><%=listeP[i].getLibJournal() %></td>
<td align=center><%=utilitaire.Utilitaire.formaterAr(listeP[i].getMontant())  %></td>
<td align=center><input type="text" name="page<%=i%>" value=<%=listeP[i].getRemis() %> ></td>
</tr>
<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">
<%}%>
</table>
<input type="hidden" name="nb" value="<%=listeP.length%>">
<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">
<input type="submit" value="valider">
</form>

<%
out.println(pr.getBasPage());
%>
</html>