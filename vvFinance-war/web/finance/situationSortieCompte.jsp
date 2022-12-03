<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/situationSortieCompte.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet dev[] = null;
        Caisse caiss[] = null;
        Caisse caiss1[] = null;
        Entree entree[] = null;
        Sortie sortieInit[] = null;
        TypeObjet enti[] =null;
        TypeObjet catCompteEntree[]=null;
        double etatInitial=0;
        double etatSortieFinal=0;
        double sommeEntree=0;
        double sommeSortie=0;
        double etatFinal=0;
        String client, idType, caisse, idDevise, idModePaiement, dateDebut, dateFin, nomCaisse,entite;
        SyntheseCompte sc[]=null;
     %>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
dev = u.findTypeObjet("Devise","%","%");
caiss = u.findCaisse("%","%","%","%");

catCompteEntree=u.findTypeObjet("CATEGORIECOMPTESOrtie","%","%");

caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
idDevise=request.getParameter("idDevise");if ((idDevise==null)||idDevise.compareTo("")==0) idDevise="%";
dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";//utiliser pour l'affichage seulement
entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
enti = u.findTypeObjet("BENEFICIAIRE","%",entite);
sc=u.findSyntheseCompteSortie(dateDebut, dateFin, caisse, entite, "%", "%");
if(caisse.compareTo("%")==0){
   nomCaisse="Tous";
}
else
  nomCaisse=u.findCaisse(caisse,"%","%","%")[0].getDescCaisse();
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Synth&egrave;se des depenses selon cat&eacute;gories des comptes </h1>
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
      <td class="left">Cat Compte:</td>

      <td><select name="caisse" class="champ" id="caisse">
          <option value="%">Tous</option>
        <%
        for(int i=0;i<caiss.length;i++){
        %>

        <option value="<%=caiss[i].getIdCaisse()%>"<%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
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
  <p class="modele">GENERAL</p>
</div>
<table width="600" border="0" align="center" class="monographe">
  <tr class="head">
    <td width="<%=100/(catCompteEntree.length+1)%>%" colspan="4">&nbsp;</td>
        <%for(int i=0;i<catCompteEntree.length;i++){%>
    <td width="<%=100/(catCompteEntree.length+1)%>%"><div align="center"><%=catCompteEntree[i].getVal()%></div></td>
    <%}%>  </tr>
  <tr>
    <td width="<%=100/(catCompteEntree.length+1)%>%" colspan="4">G&eacute;neral: </td>
<%for(int j=0;j<catCompteEntree.length;j++){%>
    <td width="<%=100/(catCompteEntree.length+1)%>%"><div align="right"><%=Utilitaire.formaterAr(AdminSyntheseCompte.calculSommeetGroupCatCompte(sc,catCompteEntree[j].getDesce()))%> Ar </div></td>
    <%}%>  </tr>
</table>

<div align="center">
  <p class="modele">DETAILS PAR ENTITE </p>
  <table width="600" border="0" align="center" class="monographe">
    <tr class="head">
      <td width="<%=100/(catCompteEntree.length+1)%>%" colspan="4">&nbsp;</td>
      <%for(int j=0;j<catCompteEntree.length;j++)
        {%>
      <td width="<%=100/(catCompteEntree.length+1)%>%"><div align="center"><%=catCompteEntree[j].getVal()%></div></td>
      <%}%> </tr>
          <%for(int l=0;l<enti.length;l++){%>
    <tr>
      <td width="<%=100/(catCompteEntree.length+1)%>%" colspan="4"><div align="right"><%=enti[l].getVal()%>: </div></td>
      <%for(int k=0;k<catCompteEntree.length;k++)
        {%>
      <td width="<%=100/(catCompteEntree.length+1)%>%"><div align="right"><a href="<%=lien%>?but=finance/detailSortieCompte.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&entite=<%=enti[l].getVal()%>&catCompte=<%=catCompteEntree[k].getDesce()%>"><%=Utilitaire.formaterAr(AdminSyntheseCompte.calculSommeetGroupCatCompte(sc,catCompteEntree[k].getDesce(),enti[l].getVal()))%> Ar </a></div></td>
      <%}%> </tr>
          <%}%>
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