<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/situationBalanceCompte.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet dev[] = null;
        Caisse caiss[] = null;
        Entree entree[] = null;
        Sortie sortieInit[] = null;
        TypeObjet enti[] =null;
        TypeObjet catCompteEntree[]=null;
        TypeObjet catCompteSortie[]=null;
        String client, idType, caisse, idDevise, idModePaiement, dateDebut, dateFin, nomCaisse,entite,ccEnt,ccSort;
        SyntheseCompte sc[]=null;
        SyntheseCompte scSortie[]=null;
     %>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dev = u.findTypeObjet("Devise","%","%");
caiss = u.findCaisse("%","%","%","%");

catCompteEntree=u.findTypeObjet("CATEGORIECOMPTEENTREE","%","%");
catCompteSortie=u.findTypeObjet("CATEGORIECOMPTESortie","%","%");

ccEnt=request.getParameter("ccEnt");if ((ccEnt==null)||ccEnt.compareTo("")==0) ccEnt="70";
ccSort=request.getParameter("ccSort");if ((ccSort==null)||ccSort.compareTo("")==0) ccSort="40";
idDevise=request.getParameter("idDevise");if ((idDevise==null)||idDevise.compareTo("")==0) idDevise="%";
dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";//utiliser pour l'affichage seulement
entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
enti = u.findTypeObjet("BENEFICIAIRE","%",entite);
sc=u.findSyntheseCompteEntree(dateDebut, dateFin, "%", entite, ccEnt, "%");
scSortie=u.findSyntheseCompteSortie(dateDebut, dateFin, "%", entite, ccSort, "%");

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Balance selon cat&eacute;gories des comptes </h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="tableauBord">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
<table width="100%" border="0" cellpadding="5" cellspacing="0" align="center" class="monographe">
  <tr>
    <td class="left">Date début :</td>
    <td><input name="dateDebut" id="dateDebut" type="text" class="champ" size="10" maxlength="10" value="<%=dateDebut%>">
          <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
    <td class="left">Date fin:</td>
    <td><input name="dateFin"  id="dateFin" type="text" class="champ" size="10" value="<%=dateFin%>">
        <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
  </tr>
  <tr>
      <td class="left">Cat Compte rec:</td>

      <td><select name="ccEnt" class="champ" id="ccEnt">
        <%
        for(int i=0;i<catCompteEntree.length;i++){
        %>

        <option value="<%=catCompteEntree[i].getDesce()%>"<%if(catCompteEntree[i].getDesce().compareTo(ccEnt)==0)out.println("selected");%>><%=catCompteEntree[i].getVal()%></option>
        <%
        }
        %>
      </select></td>
            <td class="left">Entite</td>
            <td><select name="entite" class="champ" id="entite"><option value="%">Tous</option>
                <%
for(int i=0;i<enti.length;i++){
%>
                <option value="<%=enti[i].getVal()%>" <%if(enti[i].getVal().compareTo(entite)==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                <%
}
%>
              </select></td>
  </tr>
  <tr>
    <td class="left">Cat Compte dep:</td>
    <td><select name="ccSort" class="champ" id="ccSort">
        <%
        for(int i=0;i<catCompteSortie.length;i++){
        %>

        <option value="<%=catCompteSortie[i].getDesce()%>"<%if(catCompteSortie[i].getDesce().compareTo(ccSort)==0)out.println("selected");%>><%=catCompteSortie[i].getVal()%></option>
        <%
        }
        %>
      </select></td>
    <td class="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>
</tr>

 <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center">
<input name="Annuler" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
        </table>
        <div align="center"></div></td>
  </tr>
  </table>

</form>
<div align="center">
  <p class="modele">PAR ENTITE </p>
</div>
<div align="center">
  <table width="600" border="0" align="center" class="monographe">
    <tr class="head">
      <td colspan="4">&nbsp;</td>
      <td><div align="center">Recettes</div></td>
      <td><div align="center">D&eacute;penses</div></td>
      <td><div align="center">Reste</div></td>
    </tr>
    <tr class="head">
      <td width="25%" colspan="4">Cat Comptes </td>

      <td width="25%"><div align="center"><%=ccEnt%></div></td>
	  <td width="25%"><div align="center"><%=ccSort%></div></td>
      <td width="25%"><div align="center"></div></td>
    </tr>
          <%
            double sommeTotEnt=0;
        double sommeTotSort=0;
        double sommeReste=0;
            for(int l=0;l<enti.length;l++){
            double sommeEnt=0;
            double sommeSort=0;
            double reste=0;
            sommeEnt=AdminSyntheseCompte.calculSommeetGroupCatCompte(sc,ccEnt,enti[l].getVal());
            sommeSort=AdminSyntheseCompte.calculSommeetGroupCatCompte(scSortie,ccSort,enti[l].getVal());
            reste=sommeEnt-sommeSort;

%>
    <tr>
      <td width="25%" colspan="4"><div align="right"><%=enti[l].getVal()%>: </div></td>
      <td width="25%"><div align="right"><a href="<%=lien%>?but=finance/detailEntreeCompte.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&entite=<%=enti[l].getVal()%>&catCompte=<%=ccEnt%>"><%=Utilitaire.formaterAr(sommeEnt)%> Ar </a></div></td>
<td width="25%"><div align="right"><a href="<%=lien%>?but=finance/detailSortieCompte.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&entite=<%=enti[l].getVal()%>&catCompte=<%=ccSort%>"><%=Utilitaire.formaterAr(sommeSort)%> Ar </a></div></td>
 <td width="25%"><div align="right"><%=Utilitaire.formaterAr(reste)%> Ar </div></td>
    </tr>
              <%
              sommeTotEnt=sommeTotEnt+sommeEnt;
sommeTotSort=sommeTotSort+sommeSort;
sommeReste=sommeReste+reste;

}%>
    <tr class="head">
      <td colspan="4"><div align="right">Total</div></td>
      <td><div align="right"><a href="<%=lien%>?but=finance/detailEntreeCompte.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&catCompte=<%=ccEnt%>"><%=Utilitaire.formaterAr(sommeTotEnt)%> Ar </a></div></td>
      <td><div align="right"><a href="<%=lien%>?but=finance/detailSortieCompte.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&catCompte=<%=ccSort%>"><%=Utilitaire.formaterAr(sommeTotSort)%> Ar </a></div></td>
      <td><div align="right"><%=Utilitaire.formaterAr(sommeReste)%> Ar </div></td>
    </tr>

  </table>
  <p><br>
      <script language="javascript">
var cal1 = new calendar1(document.forms['tableauBord'].elements['dateDebut']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['tableauBord'].elements['dateFin']);
cal2.year_scroll = false;
cal2.time_comp = false;
      </script>
  </p>
</div>