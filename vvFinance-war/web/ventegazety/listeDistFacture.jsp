<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="ventegazety.*" %>
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

RecetteLibelle rv=new RecetteLibelle();
rv.setNomTable("RECETTELIBELLENONFACTURE");
String listeCrt[]={"id","nom","place","province","journal","numParution","daty"};
String listeInt[]={"daty","numParution"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeDistFacture.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"nom","surnom");
pr.getFormu().changerEnChamp(liste);
String libEntete[]={"id","nom","journal","numParution","montant"};
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"montant"};
pr.setNpp(400);
pr.creerObjetPage(libEntete,colSomme);

RecetteLibelle []listeP=(RecetteLibelle [])pr.getRs().getResultat();
UnionIntraTable crtu=new UnionIntraTable();
crtu.setNomTable("distFactureLETTRE");
crtu.setId2(numObjet);
lcc=(UnionIntraTable[])CGenUtil.rechercher(crtu,null,null,"");

%>
<head>
<script language="JavaScript">
  $(document).ready(function() {
      $('#cocheTout').click(function() { // clic sur la case cocher/decocher

          var cases = $("#divchck").find(':checkbox'); // on cherche les checkbox qui dépendent de la liste 'cases'
          if(this.checked){ // si 'cocheTout' est coché
              cases.attr('checked', true); // on coche les cases
              $('#cocheText').html('Tout decocher'); // mise à jour du texte de cocheText
          }else{ // si on décoche 'cocheTout'
              cases.attr('checked', false);// on coche les cases
              $('#cocheText').html('Tout cocher');// mise à jour du texte de cocheText
          }

      });

});
</script></head>
<form action="<%=pr.getLien()%>?but=pub/apresMappage.jsp" method="POST" name="frmListe" id="frmListe">
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
          <input name="montant<%=i%>" type="hidden" class="champ" value=<%=lcc[i].getMontantMere()%> >

      <td align="right"><div align="center"><a href="<%=pr.getLien() %>?but=pub/apresMappage.jsp&idUnion=<%=lcc[i].getId()%>&acte=delete&numObjet=<%=numObjet%>&nomTable=venteFacture&bute=ventegazety/listeDistFacture.jsp">X</a> </div></td>

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
  <input type="hidden" name="nomId" value="idFacture">
  <input type="hidden" name="nomTable" value="venteFacture">
   <input name="bute" type="hidden" id="bute" value="ventegazety/listeDistFacture.jsp">
    <input name="submit" type="submit" value="valider" onClick="acte.value='svalide'">
  </div>
</form>

<h1>Liste des ventes de journaux a facturer</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/listeDistFacture.jsp&idFacture=<%=numObjet%>" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/ficheRecette.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form name="mepDist" action="<%=pr.getLien() %>?but=pub/apresMappage.jsp" method="post">
<input type='checkbox' id='cocheTout'/><span id='cocheText'>Tout cocher</span>&nbsp;&nbsp;&nbsp;
<input type="submit" value="valider" onClick="acte.value='saveMap'">
<div id="divchck">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=7% align="center" valign="top">id</td>
<td width=10% align=center valign=top>jour</td>
<td width=10% align=center valign=top>numP</td>
<td width=10% align=center valign=top>journal</td>
<td width=10% align=center valign=top>vendeur</td>
<td width=25% align=center valign=top>montant</td>
<td width=28% align=center valign=top>choix</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">
<td align=center><a href=<%=pr.getLien()%>?but=ventegazety/ficheRecette.jsp&id=<%=listeP[i].getId()%>><%=listeP[i].getId() %></a></td>
<td align=center><%=Utilitaire.formatterDaty(listeP[i].getDaty())  %></td>
<td align=center><%=listeP[i].getNumparution() %></td>
<td align=center><%=listeP[i].getJournal() %></td>
<td align=center><%=listeP[i].getNom()%></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontant())  %></td>
<td align=center><input id="checkbox<%=i%>" name="id" class="radio"  type="checkbox" value="<%=listeP[i].getId()%>"></td>
</tr>
<%}%>
</table>

<input type="hidden" name="acte" value="choix">
<input type="hidden" name="numObjet" value="<%=numObjet%>">
<input type="hidden" name="nomTable" value="venteFacture">
<input type="hidden" name="nomId" value="idFacture">
   <input name="bute" type="hidden" id="bute" value="ventegazety/listeDistFacture.jsp">
<input type="submit" value="valider" onClick="acte.value='saveMap'">
</div>
</form>

<%
pr.setApresLienPage("&idFacture="+numObjet);
out.println(pr.getBasPage());
%>
