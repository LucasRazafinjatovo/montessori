<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="facturefournisseur.*" %>
<%!
UnionIntraTable[] lcc= null;
String numObjet=null;
%>
<%
numObjet=request.getParameter("idFacture");
facturefournisseur.FactureFournisseur crtF=new facturefournisseur.FactureFournisseur();
crtF.setIdFactureFournisseur(numObjet);
crtF.setNomTable("factureClientLettre");
FactureFournisseur[] lf=(FactureFournisseur[])CGenUtil.rechercher(crtF,null,null,"");
if(lf.length==0) throw new Exception("Pas de facture client correspondante");

Pucomplet p=new Pucomplet();
p.setNomTable("pubcompletnonfacture");
String listeCrt[]={"id","libClient","idCat","idAgence","designation","numParution","pagemisyazy","datyParution","libJournal"};
String listeInt[]={"pagemisyazy","datyParution"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePubFacture.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","libClient","numParution","datyParution","montantVal","libJournal"};
String colSomme[]={"montantVal"};
pr.setAWhere(" and libclient='"+lf[0].getIdFournisseur()+"'");
pr.creerObjetPage(libEntete,colSomme);
Pucomplet []listeP=(Pucomplet [])pr.getRs().getResultat();
UnionIntraTable crtu=new UnionIntraTable();
crtu.setNomTable("pubFactureLettre");
crtu.setId2(numObjet);
lcc=(UnionIntraTable[])CGenUtil.rechercher(crtu,null,null,"");

%>
<form action="<%=pr.getLien()%>?but=pub/apresListe.jsp" method="POST" name="frmListe" id="frmListe">
  <p align="center"><strong><u>LISTE SELECTION </u></strong></p>
  <p align="center"><u><strong><a title="montant et client = " href=<%=pr.getLien()%>?but=facture/visualiserFactureClient.jsp&idBC=<%=numObjet%>>Voir d&eacute;tails facture Client num <%=numObjet%></a></strong></u></p>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr class="head">
      <td width="60%" valign="top"><div align="center">D&eacute;signation</div></td>
      <td width="34%" valign="top"><div align="center"><strong>Montant</strong></div></td>
<td width="6%" valign="top"><div align="center"><strong>Suppr</strong></div></td>
    </tr>
    <%
  for(int i=0;i<lcc.length;i++){
  %>
    <tr>
      <td align="left" valign="top"><div align="left"><%=lcc[i].getRemarque()%></div></td>
<input name="idLC<%=i%>" type="hidden" class="champ" value=<%=lcc[i].getId2()%>>
<td align="left" valign="top"><div align="left"><%=lcc[i].getMontantMereLettre()%></div></td>
      <td align="right"><div align="center"><a href="<%=pr.getLien() %>?but=pub/apresListe.jsp&idUnion=<%=lcc[i].getId()%>&acte=delete&numObjet=<%=numObjet%>">X</a> </div></td>

    </tr>
    <%
  }
  %>
      <tr>
      <td align="left" valign="top"><div align="left"></div></td>
<td align="left" valign="top"><div align="left"><%=Utilitaire.formaterAr(AdminGen.calculSommeDouble(lcc,4))  %></div></td>

    </tr>
  </table>
  <div align="center">
    <input type="hidden" name="acte" value="update">
<input type="hidden" name="nb" value="<%=lcc.length%>">
    <input name="submit" type="submit" value="enregistrer" onClick="acte.value='update'">
    <input type="hidden" name="numObjet" value="<%=numObjet%>">
    <input name="submit" type="submit" value="valider" onClick="acte.value='svalide'">
  </div>
</form>

<h1>Liste des pubicites a facturer</h1>
<form action="<%=pr.getLien()%>?but=pub/listePubFacture.jsp&idFacture=<%=numObjet%>" method="post" name="listePub" id="listePub">
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
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=20% align=center valign=top>libClient</td>
<td width=10% align=center valign=top>numP</td>
<td width=10% align=center valign=top>journal</td>
<td width=25% align=center valign=top>montantVal</td>
<td width=28% align=center valign=top>choix</td>
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
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontantVal())  %></td>
<td align=center><input name="id" class="radio"  type="checkbox" value="<%=listeP[i].getId()%>"></td>
</tr>
<%}%>
</table>
<input type="hidden" name="acte" value="choix">
<input type="hidden" name="numObjet" value="<%=numObjet%>">
<input type="submit" value="valider" onClick="acte.value='saveMap'">
</form>

<%
out.println(pr.getBasPage());
%>
