<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/tableauBordCaisse.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet dev[] = null;
        Caisse caiss[] = null;
        Caisse caiss1[] = null;
        Entree entree[] = null;
        Sortie sortieInit[] = null;
        TypeObjet enti[] =null;
        double etatInitial=0;
        double etatSortieFinal=0;
        double sommeEntree=0;
        double sommeSortie=0;
        double etatFinal=0;
		EtatCaisse etatEntree[]=null;
		EtatCaisse etatSortie[]=null;
        String client, idType, caisse, idDevise, idModePaiement, dateDebut, dateFin, nomCaisse,entite;
        EtatCaisseReste[] re=null;
        EtatCaisseReste[] tempEntite;
     %>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
caiss = u.findCaisse("%","%","%","%");
enti = u.findTypeObjet("BENEFICIAIRE","%","%");

caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";//utiliser pour l'affichage seulement
entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";

re=u.findEtatCaisseReste(dateDebut,dateFin,caisse,entite);
if(caisse.compareTo("%")==0){
   nomCaisse="Tous";
}
else
  nomCaisse=u.findCaisse(caisse,"%","%","%")[0].getDescCaisse();
tempEntite=new EtatCaisseReste[enti.length];
for (int i=0;i<enti.length;i++)
{
    tempEntite[i]=AdminEtatCaisseReste.grouperEntite(re,enti[i].getVal());
}
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.Style1 {
	font-size: 24px;
	font-weight: bold;
}
-->
</style>
<h1>Tableau de bord par Caisse entre deux dates</h1>
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
<p align="center" class="Style1">RESUME</p>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center" class="monographe">
  <!--DWLayoutTable-->
  <tr >
    <td width="171" height="19" valign="middle" class="left"> Globale : </td>
  </tr>
  <tr >
    <td height="19" valign="middle" class="left">
      <table width="100%"  border="0" class="monographe">
        <tr class="head">
          <td valign="top" ><div align="center">Etat init</div></td>
          <td valign="top" ><div align="center">Credit</div></td>
          <td valign="top" ><div align="center">Debit</div></td>
<td valign="top" ><div align="center">Variation</div></td>
          <td valign="top" ><div align="center">Reste Th</div></td>
        </tr>
        <%

    EtatCaisseReste tempo=AdminEtatCaisseReste.grouperTous(tempEntite);
  %>
        <tr>
          <td align="center"><%=Utilitaire.formaterAr(tempo.getRepEntree())%></td>
          <td align="center"><%=Utilitaire.formaterAr(tempo.getCredit())%></td>
          <td align="center"><%=Utilitaire.formaterAr(tempo.getDebit())%></td>
  <td align="center"><%=Utilitaire.formaterAr(tempo.getCredit()-tempo.getDebit())%></td>
          <td align="center"><%=Utilitaire.formaterAr(tempo.getReste())%></td>
        </tr>
    </table></td>
  </tr>
</table>
<p align="center" class="Style1">&nbsp;</p>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center" class="monographe">
  <!--DWLayoutTable-->
  <tr >
    <td width="171" height="19" valign="middle" class="left"> Entit&eacute; :</td>
  </tr>
  <tr >
    <td height="19" valign="middle" class="left">
	<table width="100%"  border="0" class="monographe">
      <tr class="head">
        <td valign="top" ><div align="center">Entite</div></td>
<td valign="top" ><div align="center">Etat init</div></td>
        <td valign="top" ><div align="center">Credit</div></td>
        <td valign="top" ><div align="center">Debit</div></td>
        <td valign="top" ><div align="center">Reste Th</div></td>
<td valign="top" ><div align="center">Report</div></td>
      </tr>
         <%
  for (int i=0;i<enti.length;i++)
  {
    EtatCaisseReste temp=tempEntite[i];
    if(temp.getCredit()+temp.getDebit()+temp.getRepDepense()+temp.getRepEntree()!=0){
  %>
      <tr>
        <td align="center"><%=temp.getEntite()%></td>
  <td align="center"><%=Utilitaire.formaterAr(temp.getRepEntree())%></td>
        <td align="center"><%=Utilitaire.formaterAr(temp.getCredit())%></td>
        <td align="center"><%=Utilitaire.formaterAr(temp.getDebit())%></td>
        <td align="center"><%=Utilitaire.formaterAr(temp.getReste())%></td>
   <td align="center"><%=Utilitaire.formaterAr(temp.getRepDepense())%></td>
      </tr>  <%}}%>
    </table></td>
  </tr>

</table>
<p>&nbsp;</p>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center" class="monographe">
  <!--DWLayoutTable-->
  <tr >
    <td width="171" height="19" valign="middle" class="left"> Caisse :</td>
  </tr>
  <tr >
    <td height="19" valign="middle" class="left"><table width="100%"  border="0" class="monographe">
      <tr class="head">
        <td valign="top" ><div align="center"><strong>Caisse</strong></div></td>
  <td valign="top" ><div align="center">Etat init</div></td>
        <td valign="top" ><div align="center">Credit</div></td>
        <td valign="top" ><div align="center">Debit</div></td>
        <td valign="top" ><div align="center">Reste</div></td>
  <td valign="top" ><div align="center">Report</div></td>
      </tr>
      <%
  for (int i=0;i<caiss.length;i++)
  {
    EtatCaisseReste temp=AdminEtatCaisseReste.grouperCaisse(re,caiss[i].getDescCaisse());
    if(temp.getCredit()+temp.getDebit()>0){
%>
        <tr>
          <td align="center"><%=temp.getDescCaisse()%></td>
<td align="center"><%=Utilitaire.formaterAr(temp.getRepEntree())%></td>
        <td align="center"><a href="<%=lien%>?but=finance/listeEntree.jsp&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&caisse=<%=Utilitaire.remplacePourcentage(temp.getDescCaisse())%>"><%=Utilitaire.formaterAr(temp.getCredit())%></a></td>
        <td align="center"><a href="<%=lien%>?but=finance/listeSortie.jsp&datyInf=<%=dateDebut%>&datySup=<%=dateFin%>&caisse=<%=Utilitaire.remplacePourcentage(temp.getIdCaisse())%>"><%=Utilitaire.formaterAr(temp.getDebit())%></a></td>
        <td align="center"><%=Utilitaire.formaterAr(temp.getReste())%></td>
<td align="center"><%=Utilitaire.formaterAr(temp.getRepDepense())%></td>
        </tr><%}}%>
    </table></td>
  </tr>
</table>
<div align="center"><br>

  <span class="Style1">DETAILS PAR DATE </span><br>
  <br>


</div>
<table width="600"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="191" valign="top" height="26"><div align="center"><strong>Daty</strong></div></td>
          <td width="192" valign="top" ><div align="center"><strong>Caisse</strong></div></td>
          <td width="192" valign="top" ><div align="center">Etat init</div></td>
          <td width="192" valign="top" ><div align="center">Credit</div></td>
          <td width="192" valign="top" ><div align="center">Debit</div></td>
          <td width="192" valign="top" ><div align="center">Reste</div></td>
 <td width="192" valign="top" ><div align="center">Report</div></td>
        </tr>
        <%
  for (int i=0;i<re.length;i++)
  {
  %>
        <tr>
          <td  height="25" align="left"><%=Utilitaire.formatterDaty(re[i].getDaty())%></td>
          <td  height="25" align="right"><%=re[i].getDescCaisse()%></td>
          <td align="right"><%=Utilitaire.formaterAr(re[i].getRepEntree())%></td>
          <td align="right"><a href="<%=lien%>?but=finance/listeEntree.jsp&dateDebut=<%=Utilitaire.formatterDaty(re[i].getDaty())%>&dateFin=<%=Utilitaire.formatterDaty(re[i].getDaty())%>&caisse=<%=Utilitaire.remplacePourcentage(re[i].getDescCaisse())%>"><%=Utilitaire.formaterAr(re[i].getCredit())%></a></td>
          <td align="right"><a href="<%=lien%>?but=finance/listeSortie.jsp&datyInf=<%=Utilitaire.formatterDaty(re[i].getDaty())%>&datySup=<%=Utilitaire.formatterDaty(re[i].getDaty())%>&caisse=<%=Utilitaire.remplacePourcentage(re[i].getIdCaisse())%>"><%=Utilitaire.formaterAr(re[i].getDebit())%></a></td>
          <td align="right"><%=Utilitaire.formaterAr(re[i].getReste())%></td>
  <td align="right"><%=Utilitaire.formaterAr(re[i].getRepDepense())%></td>
        </tr>
        <%}%>
      </table>
  </td>
  </tr>
</table>
<br>
<br>

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
