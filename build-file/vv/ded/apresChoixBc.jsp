<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresChoixListeLC.jsp";
        String lien= null;
        UserEJB u = null;

        String nomCol[]=null;
        String mois[] = Constante.getMois();


         String numObjet=null;
		 String typeObjet=null;
		 String montantObjet=null;
		 String[]idLcArecup=null;

        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
                String numCompte = null;
                String colonne = null;
                String mois2=null;String mois1=null;
                String chemin=null;
   String client, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire,designation,numBC,fournisseur,id;
             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
            Utilitaire utilitR=new Utilitaire();
  FactureFournisseur bc[] = null;
%>
<%
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";

   numBC=request.getParameter("numBC");if ((numBC==null)||numBC.compareTo("")==0) numBC="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";

  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
                  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";

  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet="%";
	idLcArecup=request.getParameterValues("idBC");
montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

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
        bc=new FactureFournisseur[idLcArecup.length];
		for(int ik=0;ik<idLcArecup.length;ik++)
       bc[ik]= u.findEntFact("BC",idLcArecup[ik], numBC, designation, fournisseur,"%","%","%",dateDebut,dateFin,"%")[0];


        //lesMontants = 0.0;//AdminLigneCreditComplet.getAllSommeMontantLC(bc);
        indiceDebut=Utilitaire.getBornePage(pazy,bc)[0];
        indiceFin=idLcArecup.length;
        nbPage=Utilitaire.calculNbPage(bc);


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
<h1>Lister les Bons de commande </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les bons de commande)</p>
<form action="<%=lien %>?but=lc/listeLC2.jsp" method="post" name="listeLC" id="listeLC">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>

        <tr>
          <td class="left">Fournisseur :</td>
          <td align="center"><input name="fournisseur" type="text" class="champ"   id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">numBC</td>
          <td align="center"><input name="numBC" type="text" class="champ"   id="numBC" value="<%=numBC%>"size="10" maxlength="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
        </tr>
        <tr>
          <td class="left">Designation :</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">id </td>
          <td align="center"><input name="id" type="text" class="champ"   id="id" value="<%=id%>"size="10" maxlength="10" /></td>
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
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="right">Créd Init</td>
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



   <form action="<%=lien%>?but=lc/visualiserLCJointure.jsp" method="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		  <td width="25%" valign="top"><div align="center">Date</div></td>
          <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="12%" height="19" valign="top"><div align="center"><strong>Fournisseur</strong></div></td>
          <td width="12%" valign="top"><div align="center"><strong>Montant TTC </strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Montant tva </strong></div></td>
          <td width="7%" valign="top"><div align="center"><strong>Montant</strong></div></td>
          <td width="11%" valign="top"><div align="center"><strong>ID BC </strong></div></td>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr>
          <td align="left" valign="top"><div align="center">
            <input name="idBC"  type='checkbox' class="radio" value="<%=bc[i].getTuppleID()%>" checked>
          </div></td>
		  <td align="left" valign="top"><div align="left"><%=bc[i].getDesignation()%></div></td>
          <td align="left" valign="top"><div align="left"><%=bc[i].getIdFournisseur()%></div></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(bc[i].getMontantTTC())%></td>
          <td align="right" valign="top"><div align="right">
  <%=utilitR.formaterAr(bc[i].calculMontantTva())%>
                            </td>
          <td align="right" valign="top"><div align="center"><input name="montant<%=i%>" type="text" class="champ" value="0"></div></td>
          <td align="right" valign="top"><div align="center">
<a href="<%=lien %>?but=lc/listeLC2.jsp&acte=details&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&idLCDetail=<%=Utilitaire.remplacePourcentage(lcc[i].getIdLigne())%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&colonne=<%=colonne%>&ordre=<%=ordre%>"><%=lcc[i].getIdLigne()%></a>
</div></td>
            </tr>
        <%
  }
  %>
     </table>
     <div align="center">
  <input type="hidden" name="acte" value="save">
       <input type="submit" value="enregistrer">
        <input type="hidden" name="numObjet" value="<%=numObjet%>">
		<input type="hidden" name="montantObjet" value="<%=montantObjet%>">
		<input type="hidden" name="typeObjet" value="<%=typeObjet%>">

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
                <a href="<%=lien %>?but=lc/listeLC2.jsp?pazy=<%=(pazy-1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
                      pr&eacute;c&eacute;dente</a>
                <%
                }

           %></td>
           <td width="305" align="right">
             <%
             if(pazy<nbPage){
             %>
             <a href="<%=lien %>?but=lc/listeLC2.jsp?pazy=<%=(pazy+1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
             suivante&gt;&gt;</a>
            <%
            }
              %></td>
          </tr>
</table>

<br />
<%


%>

