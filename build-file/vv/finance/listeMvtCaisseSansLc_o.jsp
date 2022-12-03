<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

  String nomPage = "finance/listeMvtCaisseSansLc.jsp";
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
  MvtCaisse[] mvtc= null;
  String numCompte = null;
  String colonne = null;
  String numOrdre=null;
  String mois2=null;String mois1=null;
  int nbPage = 0;
  int pazy=0;
  String pazyS = null;
int color=0;
  String maxpageS= "";
  String idMvt="";
  int maxpage=0;
  int minpage=0;
  int maxpageT=0;
  double reportInit=0;
 %>
<%

  u=(UserEJB)session.getValue("u");
 lien=(String)session.getValue("lien");
 mp = u.findTypeObjet("modepaiement","%","%");
 caiss = u.findCaisse("%","%","%","%");
 dev = u.findTypeObjet("Devise","%","%");
 tmvt= u.findTypeObjet("typemvt","%","%");
 source = u.findTypeObjet("Beneficiaire","%","%");
 tlc = u.findTypeObjet("TypeLigneCredit","%","%");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new MvtCaisse());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idDevise=request.getParameter("idDevise");if ((idDevise==null)||idDevise.compareTo("")==0) idDevise="%";
  idMode=request.getParameter("idMode");if ((idMode==null)||idMode.compareTo("")==0) idMode="%";
  idCaisse=request.getParameter("idCaisse");if ((idCaisse==null)||idCaisse.compareTo("")==0) idCaisse="%";
  agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
  tiers=request.getParameter("tiers");if ((tiers==null)||tiers.compareTo("")==0) tiers="%";
  numOrdre=request.getParameter("numOrdre");if ((numOrdre==null)||numOrdre.compareTo("")==0) numOrdre="%";
  numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
  typeMvt=request.getParameter("typeMvt");if ((typeMvt==null)||typeMvt.compareTo("")==0) typeMvt="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut=Utilitaire.dateDuJour();
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  action = request.getParameter("action");if ((action==null)||action.compareTo("")==0) action="ordonnerPayement.jsp";
idMvt=request.getParameter("idMvt");if ((idMvt==null)) idMvt="%";
  id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";

  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="id";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
  mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }

  dir = u.findDirection("","","","","");
  MvtCaisse crt=new MvtCaisse();
  crt.setNomTable("MVTCAISSELETTREValide");
  crt.setId(idMvt);
  String[]colInt={"daty"};
  String[] valInt={dateDebut,dateFin};
  crt.setDesignation(designation);
  crt.setIdDevise(idDevise);
  crt.setIdMode(idMode);
  crt.setIdCaisse(idCaisse);
  crt.setAgence(agence);
  crt.setTiers(tiers);
  crt.setIdOrdre(numOrdre);
  crt.setTypeMvt(typeMvt);
  String nomColSom[]={"debit","credit"};
  mvtCaisseRS=CGenUtil.rechercherPage(crt,colInt,valInt,pazy,"",nomColSom,colonne,ordre);

  //mvtCaisseRS = u.findMvtCaisse(idMvt,dateDebut,dateFin,"","",designation,idDevise,idMode,idCaisse,"%",agence,tiers,idLC,typeMvt,pazy);
  mvtc =(MvtCaisse[])mvtCaisseRS.getResultat();
  //System.out.println("Taille des mouvements = "+mvtc.length);
  nbPage=Utilitaire.calculNbPage(mvtCaisseRS.getSommeEtNombre()[2]);
  if((idCaisse!=null)&&(idCaisse.compareToIgnoreCase("%")!=0))
  {
    Report crtRep=new Report();
    crtRep.setNomTable("reportLettre");
    crtRep.setCaisse(idCaisse);
    Report[] repLst=(Report[])(CGenUtil.rechercher(crtRep,null,null," and daty<='"+dateDebut+"' and daty>='"+dateDebut+"'"));
    if(repLst.length>0) reportInit=repLst[0].getMontant();
  }
}
catch (Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Mouvements de caisse sans Ligne cr&eacute;dit </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les mouvements de caisse)</p>
<form action="<%=lien%>?but=<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <div align="center">
              <input name="designation" type="text" class="champ" id="designation" value="<%=designation%>">
            </div></td>
            <td class="left">Num&eacute;ro LC:</td>
            <td> <div align="center">
              <input name="idLC" type="text" class="champ" id="idLC" size="10" value="<%=idLC%>">
            </div></td>
          </tr>
          <tr>
            <td class="left">id devise </td>
            <td><div align="center">
              <select name="idDevise" class="champ" id="select">
                <option value="Ar">Ar</option>
                <%
                  for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo(idDevise)==0) out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
                  }
%>
              </select>
            </div></td>
            <td class="left">id Mouvement </td>
            <td><div align="center">
              <input name="idMvt" type="text" class="champ"   id="idMvt" value="<%=idMvt%>" size="10" maxlength="10" />


                        </div></td>
          </tr>
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
</td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
</td>
        </tr>
   <tr>
          <td class="left">id Mode</td>
          <td align="center">

<select name="idMode" class="champ" id="idMode">
<option value="%">Tous</option>
                <%
                  for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>" <%if(mp[i].getId().compareTo(idMode)==0) out.println("selected");%>><%=mp[i].getVal()%></option>
                <%
                  }
%>
              </select>

 </td>
          <td class="left">Id Caisse </td>
          <td align="center"><select name="idCaisse" class="champ" id="idCaisse">
<option value="%">Tous</option>
                <%
                  for(int i=0;i<caiss.length;i++){

%>
                <option value="<%=caiss[i].getDescCaisse()%>" <%if(caiss[i].getDescCaisse().compareTo(idCaisse)==0) out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
                  }
%>
              </select></td>
        </tr>

   <tr>
          <td class="left">Agence</td>
          <td align="center">
<input name="agence" type="text" class="champ"   id="agence" value="<%=agence%>"size="10" maxlength="10" /> </td>
          <td class="left">Tiers </td>
          <td align="center"><input name="tiers" type="text" class="champ"   id="tiers" value="<%=tiers%>" />
 </td>
        </tr>
   <tr>
          <td class="left">Num pièce</td>
          <td align="center">
<input name="numPiece" type="text" class="champ"   id="numPiece" value="<%=numPiece%>"size="10" maxlength="10" /> </td>
          <td class="left">Type mouvement </td>
          <td align="center">

    <select name="typeMvt" class="champ" id="typeMvt">
	<option value="%">Tous</option>
                <%
                  for(int i=0;i<tmvt.length;i++){
%>
                <option value="<%=tmvt[i].getVal()%>"<%if(tmvt[i].getVal().compareTo(typeMvt)==0) out.println("selected");%>><%=tmvt[i].getVal()%></option>
                <%
                  }
%>
              </select>
    </td>
        </tr>
     <tr>
          <td class="left">num ordre</td>
          <td align="center">
<input name="numOrdre" value=<%=numOrdre%> type="text" class="champ"   id="numPiece" value=""size="10" maxlength="10" /> </td>
          <td class="left"> </td>
          <td align="center">
    </td>
        </tr>
      </table></td>
    </tr>

  </table>

       <div align="center"><strong><font color="#FF0000" size="+1">TRIER
            PAR </font></strong><br>
       </div>
       <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <tr>
              <td class="left">Colonne :</td>
              <td align="center"> <select name="colonne" class="champ" id="colonne">
                  <%
                    for(int i=0;i<nomCol.length;i++){
 %>
                  <option value="<%=nomCol[i]%>"<%if(nomCol[i].compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i]%></option>
                  <%
                    }
 %>
                  </select> &nbsp;
              </td>
              <td class="left"><div align="center">Ordre :</div></td>
              <td align="center"> <select name="ordre" class="champ" id="ordre">
                  <option value="ASC" <%=(ordre.compareTo("ASC")==0?"selected":"") %>>Croissante</option>
                  <option value="DESC" <%=(ordre.compareTo("DESC")==0?"selected":"") %>>Décroissante</option>
                  </select>
              </td>
            </tr>
  </table>
       <div align="center">
  <input type="submit" name="Submit" value="Lister" class="submit">
  <input type="reset" name="annuler" value="Annuler" class="submit">



     </div>
</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top">Nb</td>
          <td width="116" align="right" valign="top"><div align="center">Report initial </div></td>
          <td width="146" align="right" valign="top"><div align="center">Somme Debit</div></td>
          <td width="160" align="right" valign="top"><div align="center"><strong>Somme Credit </strong></div></td>
          <td width="126" align="center" valign="top">Reste</td>
        </tr>

        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><%=mvtCaisseRS.getSommeEtNombre()[2] %></td>
          <td align="center"><%=utilitR.formaterAr(reportInit)%></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(mvtCaisseRS.getSommeEtNombre()[0])%></div></td>
          <td align="right"><%=utilitR.formaterAr(mvtCaisseRS.getSommeEtNombre()[1] )%></td>
          <td align="center"><div align="right"><%=utilitR.formaterAr(reportInit+mvtCaisseRS.getSommeEtNombre()[1]-mvtCaisseRS.getSommeEtNombre()[0])%></div></td></tr>
      </table>
      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
 <td align="center" valign="top">id</td>
          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Debit</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Credit </strong></div></td>
  <td width="102" align="center" valign="top">Agence</td>
                            <td width="102" align="center" valign="top">Tiers</td>
                            <td width="102" align="center" valign="top">Num Piece </td>
        </tr>
        <%
          for(int i=0;i<mvtc.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><a href=<%=lien%>?but=<%=apres%>&idMvt=<%=mvtc[i].getTuppleID()%>><%=mvtc[i].getId() %></a></td>
          <td align="center"><%=Utilitaire.formatterDaty(mvtc[i].getDaty())%></td>
          <td align="right"><div align="left"><%=mvtc[i].getDesignation()%></div></td>
                  <td align="center"><div align="right"><%=utilitR.formaterAr(mvtc[i].getDebit())%></div></td>
          <td align="right"><%=utilitR.formaterAr(mvtc[i].getCredit())%></td>
          <td align="center"><%=mvtc[i].getAgence()%></td>
          <td align="center"><%=mvtc[i].getTiers()%></td>
  <%
  if(mvtc[i].getTypeMvt().compareToIgnoreCase("virement")==0)
     {
  %>
          <td align="center"><a href=<%=lien%>?but=finance/detailVirement.jsp&idVir=<%=mvtc[i].getNumPiece()%>><%=mvtc[i].getNumPiece()%></a></td>
<%
     }
     else
     {
       %>
       <td align="center"><%=mvtc[i].getNumPiece()%></td>
<%
     }
%>


        <%
          }
  %>
      </table>
      <table cellpadding="0" cellspacing="0" align="center" class="tablesimple">
    <td align="right"><strong>page</strong> <%=pazy%> <b>sur</b>
      <%if(nbPage==0){out.print("1");}else{out.print(nbPage);}
%>
    </td>
  </tr>
    </table>

<table border="0" cellpadding="0" cellspacing="0" align="center" class="tableSimpleEtat">
  <tr>
<td><div align="center"><font size="-2">
    <%
if (pazy>minpage){
%>
    <a href="<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp&idMvt=<%=Utilitaire.remplacePourcentage(idMvt)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&idLC=<%=Utilitaire.remplacePourcentage(idLC)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=pazy-1%>&maxpageS=<%=maxpage%>&colonne=<%=colonne%>&ordre=<%=ordre%>">precedente</a>
    <%
}
%>


    <%
if(pazy<nbPage){
%>
     <a href="<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp&idMvt=<%=Utilitaire.remplacePourcentage(idMvt)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&idLC=<%=Utilitaire.remplacePourcentage(idLC)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=pazy+1%>&maxpageS=<%=maxpage%>&colonne=<%=colonne%>&ordre=<%=ordre%>">suivante </a>
     <%
}
%>
</font></div></td>
  </tr>
</table>
</td>
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