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
String etat="statPubsaisieLibelle";
//if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  //etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"idparution","journal","couleur","format","numparution"};
String listeInt[]={"numparution"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/statPubSaisie.jsp");
String libEntete[]={"idparution","journal","format","couleur","nombre","montant","numparution"};
String colSomme[]={"montant","nombre"};
pr.creerObjetPage(libEntete,colSomme);
liste=(Statpub[])pr.getListe();
%>
<h1>Stat des pub par parution</h1>
<form action="<%=pr.getLien()%>?but=pub/statPubSaisie.jsp" method="post" name="listeParution" id="listeParution">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="Parutionlibelle">Tous</option>
<option value="ParutionlibellePublie"  <%if(etat.compareTo("ParutionlibellePublie")==0) out.println("selected");%>> publie</option>
</select>
</form>
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=10% align=center valign=top>journal</td>
<td width=10% align=center valign=top>format</td>
<td width=10% align=center valign=top>couleur</td>
<td width=25% align=center valign=top>nombre verif</td>
<td width=25% align=center valign=top>nombre saisie</td>
<td width=8% align=center valign=top>parution</td>
<td width=5%></td>
</tr>

<%
for(int i=0;i<liste.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><%=liste[i].getIdparution() %></td>
<td align=center><%=liste[i].getJournal() %></td>
<td align=center><%=liste[i].getFormat() %></td>
<td align=center><%=liste[i].getCouleur() %></td>
<td align=center><%=liste[i].getNombre()  %></td>
<td align=center><%=liste[i].getMontant() %></td>
<td align=center><%=liste[i].getNumparution()%></td>
<td><a href=<%=pr.getLien()%>?but=pub/apresTarif.jsp&acte=delete&id=<%=liste[i].getIdparution()%>&bute=pub/statPubSaisie.jsp&classe=pub.Statpub>suprimer</a></td>
</tr>
<%}%>
</table>
<br>
<%
out.println(pr.getBasPage());
%>
