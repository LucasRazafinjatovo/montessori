<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet dev[] = null;
  Caisse caiss[] = null;
 Utilitaire utilitR=new Utilitaire();
  FactureFournisseur factF[] = null;
FactureFournisseur factFPage[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  historique.MapUtilisateur ut=null;
   String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire,designation,idFact,fournisseur;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
  Entree e= new Entree();
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
         dev = u.findTypeObjet("Devise","%","%");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/
     ut=u.getUser();
%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new FactureFournisseur());
                  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="%";
                  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
                  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
                  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";

                        projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
                        designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
                        fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
                        idFact=request.getParameter("idFact");if ((idFact==null)||idFact.compareTo("")==0) idFact="%";
                         apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
                         // nomCol=Utilitaire.getNomColonne(new FactureFournisseur());

                //	entree = u.findEntreeLettre("%", dateDebut, dateFin, "%", "%","%", "%",numPiece, "%", caisse, "eta2","%","%",colonne,ordre,projet, partenaire, apresW);

                //factF = u.findFactureF("%", "", "", "%", "%","%", "idFactureFournisseur", "ASC", "");
                        factF = u.findFactureFournisseur("%",  dateDebut,  dateFin, fournisseur, designation, colonne, ordre, apresW);

          int pejy=0;
          if(pazy==0){
                        pejy=0;
                        pazy=1;
          }else{
                        pejy=pazy-1;
          }
          factFPage=new FactureFournisseur[nbParPazy];
          pazy1=nbParPazy*pejy;
          pazy2=pazy*nbParPazy;
          if(pazy2>factF.length){
                pazy2=factF.length;
          }
         for(int i=pazy1;i<pazy2;i++){
                 for(int j=0;j<nbParPazy-1;j++){
                   factFPage[j]=factF[i];
                 }
          }
  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les factures fournisseurs</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
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
          <td class="left">Projet</td>
          <td align="center"><input name="projet" type="text" class="champ"   id="projet" value="<%=projet%>"size="10" maxlength="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
        </tr>
        <tr>
          <td class="left">Designation :</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">id Fact </td>
          <td align="center"><input name="idFact" type="text" class="champ"   id="idFact" value="<%=idFact%>"size="10" maxlength="10" /></td>
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
            <td align="center"> <select name="colonne"   id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre"   id="select5">
                <option value="ASC">ASC</option>
                <option value="DESC">DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">            </td>
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">            </td>
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
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="66" align="center" valign="top">id</td>

          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Fournisseur</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>

          <td width="102" align="center" valign="top">Montant Tva</td>
        </tr>
        <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="center"><a href="<%=lien%>?but=facture/visualiserFactureFournisseur.jsp&idBC=<%=factF[i].getIdFactureFournisseur()%>&nature=FactureFournisseur"><%=factF[i].getIdFactureFournisseur()%></a></td>

          <td align="center"><%=utilitR.formatterDaty(factF[i].getDaty())%></td>
          <td align="right"><%=factF[i].getDesignation()%></td>
                  <td align="center"><%=factF[i].getIdFournisseur()%></td>
          <td align="right"><%=utilitR.formaterAr((double)factF[i].getMontantTTC())%><%=" "+factF[i].getIdDevise()%></td>
          <td align="center"><%=utilitR.formaterAr(factF[i].calculMontantTva()) %>Ar</td>
          <%
    }
  %>
      </table></td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=factF.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=factF.length/nbParPazy+1%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facturefournisseur/listeFactureF.jsp&pazy=<%=pazy-1%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&fournisseur=<%=Utilitaire.remplacePourcentage(fournisseur)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&projet=<%=Utilitaire.remplacePourcentage(projet)%>&designation=<%=Utilitaire.remplacePourcentage(designation)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(factF.length>pazy2){
      %>
      <a href="<%=lien%>?but=facturefournisseur/listeFactureF.jsp&pazy=<%=pazy%>&client=<%=Utilitaire.remplacePourcentage(client)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
