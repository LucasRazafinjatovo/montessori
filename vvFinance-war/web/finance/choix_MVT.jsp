<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

  String nomPage = "choix_MVT.jsp";
  String apres="apreschoixMVT.jsp";
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
  String mois2=null;String mois1=null;
  int nbPage = 0;
  int pazy=0;
  String pazyS = null;
int color=0;
  String maxpageS= "";
  int maxpage=0;
  int minpage=0;
  int maxpageT=0;
  String champReturn = null;
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
  numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
  typeMvt=request.getParameter("typeMvt");if ((typeMvt==null)||typeMvt.compareTo("")==0) typeMvt="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  action = request.getParameter("action");if ((action==null)||action.compareTo("")==0) action="ordonnerPayement.jsp";
champReturn = request.getParameter("champReturn");
  id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
  champReturn=request.getParameter("champReturn");if ((champReturn==null)||champReturn.compareTo("")==0) champReturn="%";
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
  if ((maxpageS==null)||(maxpageS.compareTo("")==0)){maxpage=15;}
  else {
    maxpage= Utilitaire.stringToInt(request.getParameter("maxpageS"));
}
minpage = maxpage-14;
if ((pazyS==null)||(pazyS.compareTo("")==0)){pazy=1;}
else {
  pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
  dir = u.findDirection("","","","","");
  ResultatEtSomme mvtCaisseRS = u.findMvtCaisse("%",dateDebut,dateFin,"","",designation,idDevise,idMode,idCaisse,"%",agence,tiers,numPiece,typeMvt,pazy);
  mvtc =(MvtCaisse[])mvtCaisseRS.getResultat();
  nbPage=Utilitaire.calculNbPage(mvtc);
  if(maxpage>nbPage){maxpageT=nbPage;}else{maxpageT=maxpage;}
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Mouvements de caisse </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les mouvements de caisse)</p>
<form action="<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
<input type="hidden" name="champReturn" value="<%=champReturn%>">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
    <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <input name="designation" type="text" class="champ" id="designation" value="<%=designation%>"></td>
            <td class="left">Num&eacute;ro LC:</td>
            <td> <input name="idLC" type="text" class="champ" id="idLC" size="10" value="<%=idLC%>"></td>
          </tr>
          <tr>
            <td class="left">Mois 1:</td>
            <td ><select name="mois1" class="champ" id="mois1">
                <option value="%">Tous</option>
              <%
                for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois1)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
              </select></td>
            <td class="left">Mois 2:</td>
            <td><select name="mois2" class="champ" id="mois2">
              <option value="%">Tous</option>
              <%
                for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
            </select></td>
          </tr>
          <tr>
            <td class="left" valign="top">Ann&eacute;e:</td>
            <td align="left"> <select name="annee" class="champ" id="annee">
                <option value="%">Tous</option>
                <%
                  if(annee.compareTo("%")==0) annee=String.valueOf(anneeEnCours);
          for(int i=0;i<3;i++){

                %>
                <option <% if(Integer.parseInt(annee) == (anneeEnCours+1 - i)) out.println("selected");%>><%= (anneeEnCours+1 - i) %></option>
                <%
                  }
                        %>
              </select>

            </td>
            <td class="left">Direction: </td>
            <td align="center"> <div align="left">
              <select name="direction" class="champ" id="select2">
                <option value="%">Tous</option>
                <%
                  for(int i=0;i<dir.length;i++){
%>
                <option value="<%=dir[i].getIdDir()%>" <%if(dir[i].getIdDir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getAbbrevDir()%></option>
                <%
                  }
%>
              </select>

              </div></td>
          </tr>
          <tr>
            <td class="left">Num Compte:</td>
            <td><input name="numCompte" type="text" class="champ" id="numCompte3" size="10" value="<%=numCompte %>"> </td>
            <td class="left">Entit&eacute;:</td>
            <td><select name="entite" class="champ" id="select">
              <option value="%">Tous</option>
              <%
                for(int i=0;i<source.length;i++){
%>
              <option value="<%=source[i].getVal()%>" <%if(source[i].getVal().compareTo(entite)==0) out.println(" selected ");%>><%=source[i].getVal()%></option>
              <%
                }
%>
            </select> </td>
          </tr>
          <tr>
            <td class="left">Type LC: </td>
            <td><select name="idType" class="champ" id="idType" >
              <option value="%">Tous</option>
              <%
                for(int i=0;i<tlc.length;i++){
          %>
              <option value="<%=tlc[i].getVal()%>"  <%if(tlc[i].getVal().compareTo(idType)==0) out.println("selected");%>><%=tlc[i].getVal()%></option>
              <%
                }
                %>
            </select></td>
            <td class="left">etat</td>
            <td>


                        </td>
          </tr>
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>
        <tr>
          <td class="left">Designation</td>
          <td align="center">
<input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>"size="10" maxlength="10" /> </td>
          <td class="left">id devise </td>
          <td align="center"><select name="idDevise" class="champ" id="idDevise">
                <option value="Ar">Ar</option>
                <%
                  for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo(idDevise)==0) out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
                  }
%>
              </select></td>
        </tr>
   <tr>
          <td class="left">id Mode</td>
          <td align="center">

<select name="idMode" class="champ" id="idMode">

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

                <%
                  for(int i=0;i<caiss.length;i++){

%>
                <option value="<%=caiss[i].getIdCaisse()%>" <%if(caiss[i].getIdCaisse().compareTo(idCaisse)==0) out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
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
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /></td>
        </tr>
   <tr>
          <td class="left">Num pièce</td>
          <td align="center">
<input name="numPiece" type="text" class="champ"   id="numPiece" value="<%=numPiece%>"size="10" maxlength="10" /> </td>
          <td class="left">Type mouvement </td>
          <td align="center">

    <select name="typeMvt" class="champ" id="typeMvt">
                <%
                  for(int i=0;i<tmvt.length;i++){
%>
                <option value="<%=tmvt[i].getId()%>"<%if(tmvt[i].getId().compareTo(typeMvt)==0) out.println("selected");%>><%=tmvt[i].getVal()%></option>
                <%
                  }
%>
                            </select>
    </td>
        </tr>
      </table></td>
    </tr>

        </table></td>
    </tr>

  <tr>
        <td height="30" align="center"><strong><font color="#FF0000" size="+1">TRIER
          PAR </font></strong></td>
      </tr>
      <tr>
        <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
            <tr>
              <td class="left">Colonne :</td>
              <td align="center"> <select name="colonne" class="champ" id="colonne">
                  <%
                    for(int i=0;i<nomCol.length;i++){
 %>
                  <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
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
          </table></td>
      </tr>
      <tr>
        <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"> <input type="submit" name="Submit" value="Lister" class="submit">
              </td>
              <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
              </td>
            </tr>
        </table></td>
    </tr>
  </table>


</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>

   <form action="<%=apres%>" method="post" name="frmListe">
<input type="hidden" name="champReturn" value="<%=champReturn%>">
     <input name="typeObjet" type="hidden" value="<%=Constante.getObjetMvtCaisse()%>">

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
		<td width="102" align="center" valign="top">Choix</td>
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
		  <td align="center"><input name="choix" type ="radio" onmousedown="getChoix()" value="<%=mvtc[i].getId()%>" /></td>
          <td align="right"><%=mvtc[i].getId() %></td>
          <td align="center"><%=Utilitaire.formatterDaty(mvtc[i].getDaty())%></td>
          <td align="right"><%=mvtc[i].getDesignation()%></td>
                  <td align="center"><%=mvtc[i].getDebit()%></td>
          <td align="right"><%=utilitR.formaterAr(mvtc[i].getCredit())%></td>
          <td align="center"><%=mvtc[i].getAgence()%></td>
          <td align="center"><%=mvtc[i].getTiers()%></td>
          <td align="center"><%=mvtc[i].getNumPiece()%></td>
          <input type="hidden" name="nombre">




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
<td><font size="-2">
<%
if (minpage>1){
%>
<a href="choix_MVT.jsp?champReturn=<%=Utilitaire.remplacePourcentage(champReturn)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=maxpage-15%>&maxpageS=<%=maxpage-15%>"> << </a>

<%
}
%>

<%
if (pazy>minpage){
%>
<a href="choix_MVT.jsp?champReturn=<%=Utilitaire.remplacePourcentage(champReturn)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=pazy-1%>&maxpageS=<%=maxpage%>">&nbsp;&nbsp;<</a>
<%
}
%>

  <%
  for(int i=minpage;i<=maxpageT;i++){
  %>
      <a href="choix_MVT.jsp?champReturn=<%=Utilitaire.remplacePourcentage(champReturn)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=i%>&maxpageS=<%=maxpage%>">[<%=i%>]</a>
      <%
}
  %>

<%
if (pazy<maxpageT){
%>
 <a href="choix_MVT.jsp?champReturn=<%=Utilitaire.remplacePourcentage(champReturn)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=pazy+1%>&maxpageS=<%=maxpage%>">&nbsp;&nbsp;>&nbsp;&nbsp; </a>
<%
}
%>
<%
if (maxpage<nbPage){
%>
<a href="choix_MVT.jsp?champReturn=<%=Utilitaire.remplacePourcentage(champReturn)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&idDevise=<%=Utilitaire.remplacePourcentage(idDevise)%>&idMode=<%=Utilitaire.remplacePourcentage(idMode)%>&idCaisse=<%=Utilitaire.remplacePourcentage(idCaisse)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&tiers=<%=Utilitaire.remplacePourcentage(tiers)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&typeMvt=<%=Utilitaire.remplacePourcentage(typeMvt)%>&pazy=<%=maxpage+1%>&maxpageS=<%=maxpage+15%>"> >> </a>
<%
}
%>
</font></td>
  </tr>
</table>

      </form></td>
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
function getChoix(){
  setTimeout("document.frmListe.submit()",800);
}
</script>