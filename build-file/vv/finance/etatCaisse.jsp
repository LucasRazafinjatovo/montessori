<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

  String nomPage = "finance/etatCaisse.jsp";
  String apres="finance/visualiserMvtCaisse.jsp";
  String lien= null;
  UserEJB u = null;
  String action = null;
  Utilitaire utilitR=new Utilitaire();
  String designation, dateDebut, dateFin,idDevise,idMode,idCaisse,agence,tiers,numPiece,typeMvt,id;
  TypeObjet mp[] =null;
  TypeObjet tmvt[] =null;
  Caisse caiss[] = null;
  TypeObjet dev[] =null;
  ResultatEtSomme mvtCaisseRS =  null;



  String nomCol[]=null;
  String mois[] = Constante.getMois();
  String moisRang[] = Constante.getMoisRang();
  String numObjet=null;
  String typeObjet=null;
  String montantObjet=null;
  TypeObjet source[] =null;
  TypeObjet tlc[] =null;    //type ligne credit
  TypeObjet compte[] =null; //compte compta
  TypeObjet enti[] =null;
  Direction dir[] = null;
  String etat = null;
  double lesMontants[] = null;
  String typeLigne[] = {"Recette","D�pense"};
  String idLC = "";
  String idType = "";
  int anneeEnCours = Utilitaire.getAneeEnCours();
  String annee = null;
  String direction = null;
  String entite = null;
  String ordre = null;String nature2=null;
  EtatCaisseReste[] mvtc= null;
  String numCompte = null;
  String colonne = null;
  String mois2=null;String mois1=null;
  int nbPage = 0;
  int pazy=0;
  String pazyS = null;
int color=0;
  String maxpageS= "";
  int maxpage=0;
  int minpage=0;
  int maxpageT=0;
  double reportInit=0;
  double[] reportIniCaisse=null;
  RgMultiple[] groupeCaisse;
  Report[] rep=null;
  Report temp=null;
  String[] debutFin=null;
 %>
<%

  u=(UserEJB)session.getValue("u");
 lien=(String)session.getValue("lien");
 caiss = u.findCaisse("%","%","%","%");
 enti = u.findTypeObjet("typecaisse","%","%");
 debutFin=Utilitaire.getDebutFinAnnee();

%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new MvtCaisse());
  idCaisse=request.getParameter("caisse");if ((idCaisse==null)||idCaisse.compareTo("")==0) idCaisse="%";
  entite = request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut=debutFin[0];
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin=debutFin[1];
  mvtc = u.findEtatCaisseResteMvt(dateDebut,dateFin,idCaisse,entite);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Etats des caisses </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les mouvements de caisse)</p>
<form action="<%=lien%>?but=<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center" class="monographe">
              <tr>
                <td class="left">Date d&eacute;but :</td>
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
                    <option value="<%=caiss[i].getIdcaisse()%>"<%if(caiss[i].getIdcaisse().compareTo(idCaisse)==0)out.println("selected");%>><%=caiss[i].getDesccaisse()%></option>
                    <%
        }
        %>
                </select></td>
                <td class="left">Type caisse</td>
                <td><select name="entite" class="champ" id="entite">
                    <option value="%">Tous</option>
                    <%
for(int i=0;i<enti.length;i++){
%>
                    <option value="<%=enti[i].getVal()%>" <%if(enti[i].getVal().compareTo(entite)==0) out.println("selected");%>><%=enti[i].getVal()%></option>
                    <%
}
%>
                </select></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="30" align="center">
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center">
                  <input type="submit" name="Submit2" value="Afficher" class="submit">
                </td>
                <td align="center">
                  <input name="Annuler" type="reset" class="submit" value="Annuler">
                </td>
              </tr>
            </table>
            <div align="center"></div></td>
        </tr>
      </table></td>
    </tr>

  </table>
</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Caisse</td>
          <td width="116" align="right" valign="top"><div align="center">Report initial </div></td>
          <td width="146" align="right" valign="top"><div align="center">Somme Debit</div></td>
          <td width="160" align="right" valign="top"><div align="center"><strong>Somme Credit </strong></div></td>
          <td width="126" align="center" valign="top">Reste</td>
        </tr>

        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><div align="center">tous</div></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(AdminGen.calculSommeDouble(mvtc,7))%></div></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(AdminGen.calculSommeDouble(mvtc,5))%></div></td>
          <td align="right"><%=utilitR.formaterAr(AdminGen.calculSommeDouble(mvtc,4))%></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(AdminGen.calculSommeDouble(mvtc,6))%></div></td></tr>
      </table>
      <br>
      <p align="center"><strong><u>DETAIL PAR CAISSE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Caisse</td>
          <td width="116" align="right" valign="top"><div align="center">Report initial </div></td>
          <td width="146" align="right" valign="top"><div align="center">Somme Debit</div></td>
          <td width="160" align="right" valign="top"><div align="center"><strong>Somme Credit </strong></div></td>
          <td width="126" align="center" valign="top">Reste</td>
        </tr>
		<% for(int i=0;i<mvtc.length;i++)
		{
		%>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><div align="center"><a href=<%=lien%>?but=finance/listeMvtCaisse.jsp&idCaisse=<%=mvtc[i].getIdCaisse()%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>><%=mvtc[i].getDescCaisse() %></a></div></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(mvtc[i].getRepEntree())%></div></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(mvtc[i].getDebit())%></div></td>
          <td align="right"><%=Utilitaire.formaterAr(mvtc[i].getCredit())%></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(mvtc[i].getResteCalc())%></div></td>
        </tr>
		<%}%>
      </table>      <p align="center">&nbsp;</p></td>
  </tr>
</table>
<br>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>