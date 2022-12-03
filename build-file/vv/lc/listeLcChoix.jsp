<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresChoixListeLC.jsp";
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
        LigneCreditComplet lcc[]= null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        int pazyk = 1;
        String dateDebut, dateFin, projet,idFact,fournisseur;
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
        String apresW=null;
        FactureFournisseur factF[] = null;
		String numCompte = null;
		String colonne = null;
		String colonne1 = null;
		String mois2=null;String mois1=null;
		String chemin=null;

		int pazy=0;
		int nbParPazy=Parametre.getNbParPage();
		int indiceDebut=0;
		int indiceFin=Parametre.getNbParPage();
		int nbPage=0;

%>
<%
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";
  colonne1=request.getParameter("colonne1");if ((colonne1==null)||colonne1.compareTo("")==0) colonne1="daty";


  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
   mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  String indiceSelection=request.getParameter("indice");
  //int pas = Utilitaire.stringToInt(indiceSelection);
  int pas=0;
  //if((indiceSelection==null)||(indiceSelection.compareTo("")==0))
  	numObjet=request.getParameter("numObjet");
	//else numObjet=request.getParameter("numObjet"+indiceSelection);
  typeObjet=request.getParameter("typeObjet");
  montantObjet=request.getParameter("montantObjet"+indiceSelection);if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

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
        tlc = u.findTypeObjet("typesortieliste","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        lcc=u.findFCC(idLC,designation,mois1,mois2,idType,numCompte,"%","%","%",entite,direction,colonne,ordre, annee,"lignecreditcomplet");

        dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
        dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";

        lesMontants = AdminLigneCreditComplet.getAllSommeMontantLC(lcc);
        indiceDebut=Utilitaire.getBornePage(pazy,lcc)[0];
        indiceFin=Utilitaire.getBornePage(pazy,lcc)[1];
        nbPage=Utilitaire.calculNbPage(lcc);
        designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
        fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
        idFact=request.getParameter("idFact");if ((idFact==null)||idFact.compareTo("")==0) idFact="%";
        apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
        ResultatEtSomme rs= u.findFactureFournisseurPage("facturefournisseurAmapperLc",numObjet,  dateDebut,  dateFin, fournisseur, designation, colonne1, ordre, apresW,pazyk);
        factF=(FactureFournisseur[])rs.getResultat();
}
catch (Exception e){
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
<h1>liste des lignes cr&eacute;dit</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les lignes cr&eacute;dit)</p>
<form action="<%=lien %>?but=lc/listeLcChoix.jsp&numObjet=<%=numObjet%>&montantObjet=<%=montantObjet%>&indice=<%=indiceSelection%>" method="post" name="listeLC" id="listeLC">
  <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
		<input type="hidden" name="montantObjet" value="<%=montantObjet%>">
<input type="hidden" name="numObjet" value="<%=numObjet%>">
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
            <td class="left">&nbsp;</td>
            <td>&nbsp;</td>
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
</form><br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num </td>
    <td width="73%"><div align="center"><%=factF[pas].getIdFactureFournisseur()%></div></td>
  </tr>
  <tr>
    <td class="left">Nature de l'objet</td>
    <td><div align="center"><%=typeObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><%=Utilitaire.formaterAr((factF[pas].getMontantTTC()))%> Ar </div></td>
  </tr>
</table><br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="right">CRedit init </td>
          <td width="20%" align="right">Créd Modif</td>
          <td width="20%" align="right">Mont Eng</td>
          <td width="20%" align="right">Créd Dispo</td>
          <td width="10%" align="right"><strong>Nbr LC</strong></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[0]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[1]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[2]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[1]-lesMontants[2]) %> </td>
          <td align="right"><strong><%=Utilitaire.formaterAr(lesMontants[5]) %></strong></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



   <form action="<%=lien%>?but=lc/saveLCJointure.jsp" method="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="12%" height="19" valign="top"><div align="center"><strong>Credit Mod </strong></div></td>
          <td width="12%" valign="top"><div align="center"><strong>Mont eng </strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="10%" align="center" valign="top"><strong>Direction</strong></td>
          <td width="13%" valign="top"><div align="center"><strong>Mois</strong></div></td>
          <td width="7%" valign="top"><div align="center"><strong>Annee</strong></div></td>
          <td width="11%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr>
          <td align="left" valign="top"><input name="idLC" class="radio"  type='checkbox' value="<%=lcc[i].getIdLigne()%>"></td>
          <td align="left" valign="top"><div align="left"><%=lcc[i].getDesignation()%></div></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(lcc[i].getCreditModifier())%></td>
          <td align="right" valign="top"><div align="right">
                         <% chemin = lien.concat("?but=finance/listeSortie.jsp&idLigne="+lcc[i].getIdLigne());
             if(lcc[i].getMontantEng() != 0){
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(lcc[i].getMontantEng())  %></a>
                      <% } else {out.println(Utilitaire.formaterAr(lcc[i].getMontantEng())); }%></div>
          </td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getTypeLC()%></div></td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getAbbrevdir()%></div></td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getMois()%></div></td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getAnnee()%></div></td>
          <td align="right"><div align="center"><a href="<%=lien %>?but=lc/listeLC2.jsp&acte=details&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&idLCDetail=<%=Utilitaire.remplacePourcentage(lcc[i].getIdLigne())%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&colonne=<%=colonne%>&ordre=<%=ordre%>"><%=lcc[i].getIdLigne()%></a> </div></td>

        </tr>
        <%

  }
  %>
     </table>
     <div align="center">
	    <input type="submit" value="selectionner">
        <input type="hidden" name="numObjet" value="<%=factF[pas].getIdFactureFournisseur()%>">
		<input type="hidden" name="montantObjet" value="<%=factF[pas].getMontantTTC()%>">
		<input type="hidden" name="avecOp" value="<%=request.getParameter("avecOp")%>">
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
                <a href="<%=lien %>?but=lc/listeLcChoix.jsp&pazy=<%=(pazy-1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>&numObjet=<%=numObjet%>&montantObjet=<%=montantObjet%>&indice=<%=indiceSelection%>">&lt;&lt;Page
                      pr&eacute;c&eacute;dente</a>
                <%
                }

           %></td>
           <td width="305" align="right">
             <%
             if(pazy<nbPage){
             %>
             <a href="<%=lien %>?but=lc/listeLcChoix.jsp&pazy=<%=(pazy+1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>&numObjet=<%=numObjet%>&montantObjet=<%=montantObjet%>&indice=<%=indiceSelection%>">&lt;&lt;Page
             suivante&gt;&gt;</a>
            <%
            }
              %></td>
          </tr>
</table>

<br />
<%
        if(request.getParameter("acte")!=null){
                LigneCreditComplet l = u.findLCComplet(request.getParameter("idLCDetail"),"","","","","","","","","","idLigne","ASC","","lignecreditcomplet")[0];
                %>
                <p align="center"><strong><u>Détail Ligne Crédit</u></strong></p>
      <table width="75%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
              <tr>
              <td width="40%" height="30" class="left">Id Ligne Crédit:</td>
              <td><%=l.getIdLigne() %></td>
              </tr>
                <tr>
              <td height="30" class="left">Désignation:</td>
              <td><%=l.getDesignation() %></td>
              </tr>
              <tr>
              <td height="30" class="left">Type d'utilisation:</td>
              <td><%=l.getTypeLC() %></td>
              </tr>
              <tr>
              <td height="30" class="left">Crédit Initial:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditInitial()) %></td>
              </tr>
              <tr>
              <td height="30" class="left">Crédit Actuel:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditModifier()) %></td>
              </tr>
              <tr>
              <td height="30" class="left">Crédit Dispo:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditModifier()-l.getMontantEng()) %></td>
              </tr>
              <tr>
              <td height="30" class="left">Montant Engagé:</td>
              <td>
              <% if(l.getTypeLC().compareToIgnoreCase("Recette")==0)
                              chemin = lien.concat("?but=finance/listeEntree.jsp&idLigne="+l.getIdLigne());
                       else
                              chemin = lien.concat("?but=finance/listeSortie.jsp&idLigne="+l.getIdLigne());
             if(l.getMontantEng() != 0){
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(l.getMontantEng())  %></a>
                      <% } else {out.println(Utilitaire.formaterAr(l.getMontantEng())); }%>
              </td>
              </tr>
              <tr>
              <td height="30" class="left">Montant Visa:</td>
              <td><%=Utilitaire.formaterAr(l.getMontantVis()) %></td>
              </tr>
              <tr>
              <td height="30" class="left">Montant Facturé:</td>
              <td><%=Utilitaire.formaterAr(l.getMontantFac()) %></td>
              </tr>
              <tr>
              <td height="30" class="left">Direction:</td>
              <td><%=l.getLibelledir()+" ("+l.getAbbrevdir()+")" %></td>
              </tr>
              <tr>
              <td height="30" class="left">Entité:</td>
              <td><%=l.getEntite() %></td>
              </tr>
              <tr>
              <td height="30" class="left">Num Compte:</td>
              <td><%=l.getNumCompte()+ " ("+l.getDescCompte()+")" %></td>
              </tr>
              <tr>
              <td height="30" class="left">Excercice:</td>
              <td><%=l.getMois()+ " "+l.getAnnee() %></td>
              </tr>
                <tr>
              <td height="30" class="left">Parution :</td>
              <td><%=l.getParution() %></td>
              </tr>
</table>
                <%
        }
%>

