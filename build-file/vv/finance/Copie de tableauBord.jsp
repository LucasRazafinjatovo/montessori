<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/tableauBord.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet dev[] = null;
        TypeObjet te[] = null;
        TypeObjet ts[] = null;
        Caisse caiss[] = null;
        Caisse caiss1[] = null;
        Entree entree[] = null;
        Entree entreeF[] = null;
        Sortie sortieF[] = null;
        Sortie sortieInit[] = null;
        double etatInitial=0;
        double etatSortieFinal=0;
        double sommeEntree=0;
        double sommeSortie=0;
        double etatFinal=0;
        String client, idType, caisse, idDevise, idModePaiement, dateDebut, dateFin, nomCaisse;
     %>
<%
try{
u=(UserEJB)session.getValue("u");
te = u.findTypeObjet("TypeEntree","%","%");
ts = u.findTypeObjet("TypeSortie","%","%");
lien=(String)session.getValue("lien");
dev = u.findTypeObjet("Devise","%","%");
caiss = u.findCaisse("%","%","%","%");

caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
idDevise=request.getParameter("idDevise");if ((idDevise==null)||idDevise.compareTo("")==0) idDevise="%";
dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";//utiliser pour l'affichage seulement
if(caisse.compareTo("%")==0){
   nomCaisse="Tous";
}
else
  nomCaisse=u.findCaisse(caisse,"%","%","%")[0].getDescCaisse();
//if (idDevise.compareTo("%")==0) idDevise="Tous";
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Tableau de bord entre deux dates</h1>
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
      <td class="left">Caisse :</td>

 <td><select name="caisse" class="champ" id="caisse">
          <option value="%">Tous</option>
        <%
        for(int i=0;i<caiss.length;i++){
        %>

        <option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
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
<br>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center" class="monographe">
  <!--DWLayoutTable-->
  <tr >
    <td width="171" height="19" valign="middle" class="left"> &nbsp;Caisse :</td>
    <td width="145" valign="middle" > <div align="right"><%=nomCaisse%>&nbsp;
      </div></td>
    <td width="140" valign="middle" class="left"> <!--&nbsp;Devise :--></td>
    <td width="140" valign="middle"> <div align="right"><!--<%=idDevise%>--></div>
      &nbsp;</td>
  </tr>
</table>
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <!--DWLayoutTable-->
  <tr >
    <td width="171" height="19" valign="middle" class="left"> <strong>&nbsp;Etat
      initial :</strong></td>
    <td width="145" valign="middle" > <div align="right">&nbsp; </div></td>
    <td width="140" valign="middle" class="left">&nbsp;Etat final : </td>
    <td width="140" valign="middle"> <div align="right"> </div>
      &nbsp;</td>
  </tr>
	<%
	  for (int k=0;k<dev.length;k++){

    entree = u.findEntree("%", dateDebut, dateDebut, "%", "TENT015", "%", "%", dev[k].getId(), caisse, "eta2");//entree de type report (tEnt3)
    sortieInit = u.findSortie("%",dateFin,dateFin,"%","TS020","%", "%", dev[k].getId(), caisse, "eta2");//n'affiche que les sorties crees seulement, n'affiche pas le annulees

	entreeF = u.findEntree("%", dateDebut, dateFin, "%", "%", "%", "%", dev[k].getId(), caisse, "eta2");//entree  entre deux dates
    sortieF = u.findSortie("%",dateDebut,dateFin,"%","%","%", "%", dev[k].getId(), caisse, "eta2");//n'affiche que les sorties crees seulement, n'affiche pas le annulees
    etatInitial = AdminEntree.getSommeEntree(entree);
    etatSortieFinal=AdminCharge.getSommeSortie(sortieInit);
    sommeEntree=AdminEntree.getSommeEntree(entreeF);//somme entree entre deux dates données
    sommeSortie=AdminCharge.getSommeSortie(sortieF); // somme sortie entre deux dates données
    etatFinal=sommeEntree+etatSortieFinal-sommeSortie; //etat final de la caisse

	//entreeF = u.findEntree("%", dateDebut, dateFin, "%", "%", "%", "%", dev[k].getId(), caisse, "eta2");//entree  entre deux dates
%>

  <tr >
    <td height="19" valign="middle" class="left"><strong><font color="#999999"><%=dev[k].getVal()%>
      :</font></strong> </td>
    <td valign="middle" ><div align="right"><%=Utilitaire.formaterAr(etatInitial)%> <%=dev[k].getVal()%></div></td>
    <td valign="middle" class="left"><strong><font color="#999999"><%=dev[k].getVal()%> :</font></strong>
    </td>
    <td valign="middle"><div align="right"><%=Utilitaire.formaterAr(etatFinal)%> <%=dev[k].getVal()%></div></td>
  </tr>
  <%}%>
</table>
<br>
<br>
<br>
<table width="600"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<table width="295"  border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="191" valign="top" height="25"><strong>&nbsp; Recettes par type
            :</strong></td>
          <td width="192" valign="top" ><div align="right"><strong>Montant :</strong></div></td>
        </tr>
        <%
  for (int i=0;i<te.length;i++)
  {
  %>
        <tr bgcolor="#999999" height="25">
          <td colspan="2" valign="middle"> <div align="center">
              <font color="#FFFFFF"><b><%=te[i].getVal()%></b></font>
            </div></td>
        </tr>
        <%
      for (int k=0;k<dev.length;k++){
	       entreeF = u.findEntree("%", dateDebut, dateFin, "%", "%", "%", "%", dev[k].getId(), caisse, "eta2");//entree  entre deux dates
	if (finance.AdminEntree.getSommeEntreeByType(entreeF,te[i].getId())>0)
	  {
%>
        <tr>
          <td  height="25" align="left"><strong><font color="#999999">Total en
            <%=dev[k].getVal()%> :</font></strong> </td>
          <td  height="25" align="right"><%=Utilitaire.formaterAr((double)(finance.AdminEntree.getSommeEntreeByType(entreeF,te[i].getId())))%> <%=dev[k].getVal()%> </td>
        </tr>
        <%}}%>
        <%}%>
      </table>
  </td>
  <td width="10"></td>
  <td valign="top">
  <table width="295" border="0" align="center" valign="top" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="185" valign="top" height="25"> &nbsp;Sorties par type
            :</td>
          <td width="195" valign="top"><div align="right">Montant :</div></td>
        </tr>
        <%
 for (int i=0;i<ts.length;i++){
%>
        <tr bgcolor="#999999">
          <td colspan="2" valign="middle" height="25"> <div align="center"> <font color="#FFFFFF"><b><%=ts[i].getVal()%></b></font> </div></td>
        </tr>
        <%
      for (int k=0;k<dev.length;k++){
        sortieF = u.findSortie("%",dateDebut,dateFin,"%","%","%", "%", dev[k].getId(), caisse, "eta2");
  		if (finance.AdminCharge.getSommeSortieByType(sortieF,ts[i].getId())>0)
		{
  %>
        <tr>
          <td  height="25" align="left"><strong><font color="#999999">Total en
            <%=dev[k].getVal()%> :</font></strong> </td>
          <td  height="25" align="right"><%=Utilitaire.formaterAr((double)(finance.AdminCharge.getSommeSortieByType(sortieF,ts[i].getId())))%> <%=dev[k].getVal()%> </td>
        </tr>
        <%}}%>
        <%}%>
      </table>

  </td>
  </tr>
  </table>
<br>
<br>




 <table width="600"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<table width="295"  border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td height="25" colspan="2" valign="top" class="titreMoyen"><div align="center"><strong>TOTAL
              RECETTES</strong></div></td>
        </tr>
        <%
      for (int k=0;k<dev.length;k++){
        entreeF = u.findEntree("%", dateDebut, dateFin, "%", "%", "%", "%", dev[k].getId(), caisse, "eta2");//entree  entre deux dates
%>
        <tr>
          <td  height="25" align="left"><strong><font color="#999999">Total en
            <%=dev[k].getVal()%> :</font></strong> </td>
          <td  height="25" align="right"><%=Utilitaire.formaterAr((double)(finance.AdminEntree.getSommeEntree(entreeF)))%> <%=dev[k].getVal()%> </td>
        </tr>
        <%}%>
      </table>
  </td>
  <td width="10"></td>
  <td>
  <table width="295" border="0" align="center" valign="top" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td height="25" colspan="2" valign="top" class="titreMoyen"><div align="center">TOTAL
              SORTIES</div></td>
        </tr>
        <%
      for (int k=0;k<dev.length;k++){
        sortieF = u.findSortie("%",dateDebut,dateFin,"%","%","%", "%", dev[k].getId(), caisse, "eta2");
  %>
        <tr>
          <td  height="25" align="left"><strong><font color="#999999">Total en
            <%=dev[k].getVal()%> :</font></strong> </td>
          <td  height="25" align="right"><%=Utilitaire.formaterAr((double)(finance.AdminCharge.getSommeSortie(sortieF)))%> <%=dev[k].getVal()%> </td>
        </tr>
        <%}%>
      </table>

  </td>
  </tr>
  </table>

<p class="titreMoyen"><br>
  <script language="javascript">
var cal1 = new calendar1(document.forms['tableauBord'].elements['dateDebut']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['tableauBord'].elements['dateFin']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
</p>
