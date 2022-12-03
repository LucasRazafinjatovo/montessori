<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%!
Statpub[] liste;
%>
<%
Statpub p=new Statpub();
String etat="statPubLibelle";
//if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  //etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"idparution","journal","couleur","format","numparution","montant"};
String listeInt[]={"numparution","montant"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/statPub.jsp");
String libEntete[]={"idparution","journal","format","couleur","nombre","montant","numparution"};
String colSomme[]={"montant","nombre"};
pr.creerObjetPage(libEntete,colSomme);
liste=(Statpub[])pr.getListe();
%>
<h1>Stat des pub par parution</h1>
<form action="<%=pr.getLien()%>?but=pub/statPub.jsp" method="post" name="listeParution" id="listeParution">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="Parutionlibelle">Tous</option>
<option value="ParutionlibellePublie"  <%if(etat.compareTo("ParutionlibellePublie")==0) out.println("selected");%>> publie</option>
</select>
</form>
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">parution</td>
<td width=10% align=center valign=top>journal</td>
<td width=10% align=center valign=top>format</td>
<td width=10% align=center valign=top>couleur</td>
<td width=25% align=center valign=top>nombre</td>
<td width=28% align=center valign=top>montant</td>
<td width=10% align=center valign=top>parution</td>
</tr>

<%
for(int i=0;i<liste.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><a href=<%=pr.getLien()%>?but=pub/listePub.jsp&numParution1=<%=liste[i].getNumparution()%>&numParution2=<%=liste[i].getNumparution()%>&libJournal=<%=liste[i].getJournal()%>&idMont=<%=liste[i].getFormat()%>&couleur=<%=liste[i].getCouleur() %>><%=liste[i].getIdparution() %></a></td>
<td align=center><%=liste[i].getJournal() %></td>
<td align=center><%=liste[i].getFormat() %></td>
<td align=center><%=liste[i].getCouleur() %></td>
<td align=center><%=liste[i].getNombre()  %></td>
<td align=center><%=Utilitaire.formaterAr(liste[i].getMontant()) %></td>
<td align=center><%=liste[i].getNumparution()%></td>
</tr>
<%}%>
</table>
<br>
<%
out.println(pr.getBasPage());
%>
