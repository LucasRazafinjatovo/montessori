<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

  String nomPage = "compte/rapport.jsp";
  String lien= null;
  UserEJB u = null;
  String action = null;
  Utilitaire utilitR=new Utilitaire();
  String designation, dateDebut, dateFin,idDevise,idMode,agence,tiers,numPiece,typeMvt,id;
  TypeObjet mp[] =null;
  TypeObjet tmvt[] =null;
  Caisse caiss[] = null;
  Caisse caissnoncloture[] = null;
  Caisse caisse = null;
  TypeObjet dev[] =null;
  ResultatEtSomme mvtCaisseRS =  null;
  Rib rib= null;
  Rib listeRib[]=null;
  MvtCaisseLc mvtcaisse=null;
  MvtCaisseLc lmvtcaissenonrapproche[]=null;

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
  String typeLigne[] = {"Recette","Dépense"};
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
  String prev2 = null;
  String prev1 = null;
 %>
<%
  try{
  rib=new Rib();
  listeRib=(Rib[])CGenUtil.rechercher(rib,null,null," order by daty desc");
  u=(UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  caiss = u.findCaisse("%","%","%","%");
  caisse = new Caisse();
  enti = u.findTypeObjet("BENEFICIAIRE","%","%");
  nomCol=Utilitaire.getNomColonne(new MvtCaisse());
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  dateDebut=request.getParameter("dateDu");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut=Utilitaire.dateDuJour();
  dateFin=dateDebut;
  prev2 = utilitR.getPrevDate(-2,dateDebut);
  prev1 =  utilitR.getPrevDate(-1,dateDebut);
  mvtc = u.findEtatCaisseReportMvt(prev2,prev1,"%",entite);
  caissnoncloture = (Caisse[])CGenUtil.rechercher(caisse,null,null," and idcaisse not in(select objet from clotureAff where typeobjet='caisse' and daty='"+dateDebut+"')");
  mvtcaisse=new MvtCaisseLc();
  String etat="MvtCaisse";
  mvtcaisse.setNomTable(etat);
  lmvtcaissenonrapproche = (MvtCaisseLc[])CGenUtil.rechercher(mvtcaisse,null,null," and daty <='"+dateDebut+"' and numpiece not in(select numcheque from rib where daty <='"+dateDebut+"')");
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
<form action="<%=lien%>?but=<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center" class="monographe">
              <tr>
                <td class="left">Date d&eacute;but :</td>
                <td><input name="dateDu" id="dateDebut" type="text" class="champ" size="10" maxlength="10" value="<%=dateDebut%>">
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
    <td> <p align="center"><strong><u>RECAPITULATION REPORT</u></strong></p>


      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Caisse</td>
          <td width="126" align="center" valign="top">Report Pratique</td>
          <td width="126" align="center" valign="top">Report Théorique</td>
        </tr>

        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><div align="center">tous</div></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(AdminGen.calculSommeDouble(mvtc,7))%></div></td>
          <td align="center"><div align="right"><%=0%></div></td></tr>
      </table>
      <br>
      <p align="center"><strong><u>RAPPORT PAR CAISSE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Caisse</td>
          <td width="126" align="center" valign="top">Report pratique</td>
          <td width="126" align="center" valign="top">Report théorique</td>
        </tr>
                <% for(int i=0;i<mvtc.length;i++)
                {
                %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><div align="center"><a href=<%=lien%>?but=finance/listeMvtCaisse.jsp&idCaisse=<%=mvtc[i].getIdCaisse()%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>><%=mvtc[i].getDescCaisse() %></a></div></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(mvtc[i].getRepEntree())%></div></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(mvtc[i].getRepDepense())%></div></td>
        </tr>
                <%}%>
      </table>      <p align="center">&nbsp;</p></td>
  </tr>
</table>
<br>
<div>
   <p align="center"><strong><u>LISTE CAISSES NON CLOTUREES</u></strong></p>
   <table>
   <%  for(int i=0;i<caissnoncloture.length;i++){
   %>
   <tr>
      <td><%=caissnoncloture[i].getDescCaisse()%> </td>
   </tr>
   <% } %>
   </table>
</div>
<div>
   <p align="center"><strong><u>VERIFICATION RAPPROCHEMENT BANCAIRE</u></strong></p>
<%if(listeRib.length>0){
    if(Utilitaire.diffJourDaty(Utilitaire.datetostring(listeRib[0].getDaty()),dateDebut)<0) { %>
     <div> date du dernier RIB inférieur au jour  de consultation </div>
    <% } %>
<% } %>
<% if(lmvtcaissenonrapproche.length>0){%>
   <table>
   <%  for(int i=0;i<lmvtcaissenonrapproche.length;i++){
   %>
   <tr>
      <td><%=lmvtcaissenonrapproche[i].getAgence()%> </td>
      <td><%=lmvtcaissenonrapproche[i].getDesignation()%> </td>
   </tr>
   <% } %>
   </table>
<%}%>
</div>