<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="ded/listeChoixDed.jsp";
        String nomFichier="ded/apresListeChoixDed.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
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
        DedLc lcc[]= null;
        //double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null; String nature2="ded";

                String numCompte = null;
                String colonne = null;
                String mois2=null;String mois1=null;
                String chemin=null;
        String idDED,dateDebut,dateFin,fournisseur,designationDed;
             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();           int nbPage=0;
		   String[] idLcArecup=null;
                   String valeurPropose="0";
                   String id = null;
LcDetail lcd[] = null;
String compteDet = null;
String etat = null;
String idOP = null;
%>
<%
nature2=request.getParameter("nature2");if ((nature2==null)||nature2.compareTo("")==0) nature2=Constante.getObjetOp();

  nomCol=Utilitaire.getNomColonne(new DedLc());
  idOP=request.getParameter("idOP");if ((idOP==null)||idOP.compareTo("")==0) idOP="%";
  idDED=request.getParameter("idDed");if ((idDED==null)||idDED.compareTo("")==0) idDED="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  designationDed=request.getParameter("designationDed");if ((designationDed==null)||designationDed.compareTo("")==0) designationDed="%";
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

 String indiceSelection=request.getParameter("indice");

  numObjet=request.getParameter("numObjet");
  typeObjet=request.getParameter("typeObjet");
  montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

idLcArecup=request.getParameterValues("idLC");
  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }

 %>
<%

try{
        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        source = u.findTypeObjet("Beneficiaire","%","%");
        tlc = u.findTypeObjet("TypeLigneCredit","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        lcd=new LcDetail[idLcArecup.length];
        if(idLcArecup.length==1) valeurPropose=montantObjet;

        for(int ik=0;ik<idLcArecup.length;ik++)
        {                          //(id, desi, daty1, daty2, mont1, mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2)
          lcd[ik]=u.findDetailLc(idLcArecup[ik],"%","%","%")[0];

        }
        //lesMontants = rs.getSommeEtNombre();


}
catch (Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script type="text/javascript">
<!--
 function getChoix(){
  setTimeout("document.frmListe.submit()",800);
}
//-->
</script>


<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Ordres de paiement </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les ordres de paiement)</p>
<form action="<%=lien %>?but=<%=nomFichier%>" method="post" name="listeLC" id="listeLC">

  <div align="left">
    <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
              <input type="hidden" name="montantObjet" value="<%=montantObjet%>">
    <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
      <tr>
        <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
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
                        <select name="etat" class="champ" id="etat" >
              <option value="%">Tous</option>
                          <option value="0"  <%if(etat.compareTo("0")==0) out.println("selected");%>>non valide</option>
            <option value="1"  <%if(etat.compareTo("1")==0) out.println("selected");%>> valide</option>
            </select>

                        </td>
          </tr>
 <tr>
            <td class="left">idDed: </td>
            <td><input name="idDed" type="text" class="champ" id="idDed" value="<%=idDED%>"></td>
            <td class="left">idOP</td>
            <td><input name="idOP" type="text" class="champ" id="idOP" value="<%=idOP%>"></td>
          </tr>
		   <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
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
  </div>
</form><br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num <%=typeObjet%></td>
    <td width="73%"><div align="center"><%=numObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Nature de l'objet</td>
    <td><div align="center"><%=typeObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><%=Utilitaire.formaterAr(Utilitaire.stringToDouble(montantObjet))%> Ar </div></td>
  </tr>
</table><br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="right">CRedit init </td>
          <td width="20%" align="right">Montant eng</td>
          <td width="20%" align="right">Montant visa</td>
          <td width="20%" align="right">Montant fact</td>
          <td width="10%" align="right"><strong>Nbr LC</strong></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"</td>
          <td align="right"></td>
          <td align="right"></td>
          <td align="right"> </td>
          <td align="right"><strong></strong></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



   <form action="<%=lien%>?but=ded/enregistrerDedJointure.jsp" method="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="25%" valign="top"><div align="center">id</div></td>
          <td width="12%" height="19" valign="top"><div align="center"><strong>idLC </strong></div></td>
            <td valign="top"><div align="center"><strong>Compte det</strong></div></td>
          <td valign="top"><div align="center"><strong>Eng</strong></div></td>
          <td valign="top"><div align="center"><strong>Visa</strong></div></td>
<td valign="top"><div align="center"><strong>Fact</strong></div></td>
 <td valign="top"><div align="center"><strong>Montant</strong></div></td>
        </tr>
        <%
  for(int i=0;i<lcd.length;i++){
  %>
        <tr>
  <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="25%" valign="top"><div align="center"><input name="idLC" class="radio"  type='checkbox' value="<%=lcd[i].getId()%>"></div></td>
          <td width="12%" height="19" valign="top"><div align="center"><strong><%=lcd[i]%>idLC </strong></div></td>
            <td valign="top"><div align="center"><strong><%=Utilitaire.formaterAr(lcd[i].getCompteDetail())%>Compte det</strong></div></td>
          <td valign="top"><div align="center"><strong><%=Utilitaire.formaterAr(lcd[i].getMontantEng())%>Eng</strong></div></td>
          <td valign="top"><div align="center"><strong><%=Utilitaire.formaterAr(lcd[i].getMontantVis())%>Visa</strong></div></td>
  <td valign="top"><div align="center"><strong><%=Utilitaire.formaterAr(lcd[i].getMontantFact())%>Fact</strong></div></td>
   <input name="montant<%=i%>" type="text" class="champ" value=<%=valeurPropose%>>
        </tr>
        <%
  }
  %>
     </table>
     <div align="center">
        <input type="hidden" name="numObjet" value="<%=numObjet%>">
                <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
                <input type="hidden" name="montantObjet" value="<%=montantObjet%>">
   <input type="hidden" name="nature2" value="<%=nature2%>">
                <input type="hidden" name="acte" value="save">
                <input name="submit" type="submit" value="enregistrer">
                <input name="submit" type="submit" value="enregistrer et valider" onClick="acte.value='svalide'">
</div>
   </form>
   <br />
   <!-- Pagination -->
   <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
        <tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=lcc.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=Math.floor(lcc.length/nbParPazy)+1%></td>
        </tr>
            <tr>
            <td width="295" valign="top" height="25">
                <%if(pazy>1){%>
                <a href="<%=lien %>?but=<%=nomFichier%>&pazy=<%=(pazy-1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
                      pr&eacute;c&eacute;dente</a>
                <%
                }

           %></td>
           <td width="305" align="right">
             <%
             if(pazy<nbPage){
             %>
             <a href="<%=lien %>?but=<%=nomFichier%>&pazy=<%=(pazy+1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
             suivante&gt;&gt;</a>
            <%
            }
              %></td>
          </tr>
</table>

<br />

