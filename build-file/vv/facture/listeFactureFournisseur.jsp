<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="ded/listeFactureFournisseur.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet dev[] = null;
  Caisse caiss[] = null;
  Utilitaire utilitR=new Utilitaire();
  FactureFournisseur bc[] = null;
  FactureFournisseur factFPage[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  historique.MapUtilisateur ut=null;
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire,designation,numBC,fournisseur,id;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int indiceDebut=0,nbPage;
  int indiceFin=0;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
  String numObjet=null;
  String typeObjet=null;
  String montantObjet=null;
  String nature=null;
  String suivant=null;
 %>
<%
  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
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
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="daty";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="BC";
  id=request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  numBC=request.getParameter("numBC");if ((numBC==null)||numBC.compareTo("")==0) numBC="%";
  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";

  String indiceSelection=request.getParameter("indice");
  numObjet=request.getParameter("numObjet"+indiceSelection);
  typeObjet=request.getParameter("typeObjet");
  montantObjet=request.getParameter("montantObjet"+indiceSelection);if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

  nomCol=Utilitaire.getNomColonne(new FactureFournisseur());

  //	entree = u.findEntreeLettre("%", dateDebut, dateFin, "%", "%","%", "%",numPiece, "%", caisse, "eta2","%","%",colonne,ordre,projet, partenaire, apresW);

  //findFactureFournisseur(  String colonne, String ordre, String apresW)
  suivant="&numBC="+Utilitaire.remplacePourcentage(request.getParameter("numBC"))+"&fournisseur="+Utilitaire.remplacePourcentage(request.getParameter("fournisseur"))+"&dateDebut="+dateDebut+"&id="+Utilitaire.remplacePourcentage(request.getParameter("id"))+"&dateFin="+dateFin+"&designation="+Utilitaire.remplacePourcentage(request.getParameter("designation"))+"&colonne="+colonne+"&ordre="+ordre;
  ResultatEtSomme rs = u.findFactureFournisseurPage(nature,id,dateDebut,dateFin,fournisseur,designation,colonne,ordre,"",pazy);
  bc=(FactureFournisseur[])rs.getResultat();
  indiceDebut=Utilitaire.getBornePage(pazy,bc)[0];
  indiceFin=Utilitaire.getBornePage(pazy,bc)[1];
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
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister des Factures Fournisseur</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les Factures fournisseur)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">

  <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
  <input type="hidden" name="montantObjet" value="<%=montantObjet%>">

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
          <td align="center"><input name="fournisseur" type="text" class="champ"   id="fournisseur" value="<%=fournisseur%>"size="10"/>
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">numBC</td>
          <td align="center"><input name="numBC" type="text" class="champ"   id="numBC" value="<%=numBC%>"size="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
        </tr>
        <tr>
          <td class="left">Designation :</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">id </td>
          <td align="center"><input name="id" type="text" class="champ"   id="id" value="<%=id%>"size="10"/></td>
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
<form action="<%=lien%>?but=facture/visualiserFactureFournisseur.jsp" method="post">

     <input name="nature" type="hidden" value="<%=nature%>">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
<td width="66" align="center" valign="top"></td>
          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Fournisseur</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>

          <td width="102" align="center" valign="top">Montant Tva</td>
          </tr>
        <%
          for(int i=0;i<bc.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
<td align="center"><input name="idBC" class="radio"  type='radio' value="<%=bc[i].getIdFactureFournisseur() %>" onClick="page('<%=lien%>?but=ded/visualiserBc.jsp')"></td>
          <td align="center"><%=utilitR.formatterDaty(bc[i].getDaty())%></td>
          <td align="right"><%=bc[i].getDesignation()%></td>
                  <td align="center"><%=bc[i].getIdFournisseur()%></td>
          <td align="right"><%=utilitR.formaterAr((double)bc[i].getMontantTTC())%><%=" "+bc[i].getIdDevise()%></td>
          <td align="center"><%=utilitR.formaterAr(bc[i].calculMontantTva()) %>Ar</td>
    <input type="hidden" name="nombre">

<input type="hidden" name="numObjet<%=i%>" value="<%=bc[i].getIdFactureFournisseur()%>">
<input type="hidden" name="montantObjet<%=i%>" value="<%=bc[i].getMontantTTC()%>">
            <%
              }
  %>
      </table>
      <div align="center">
        <input name="valide" type="submit" value="choisir">
      </div>
      </form>
</td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=bc.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=bc.length/nbParPazy+1%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy>1){%>
       <a href="<%=lien%>?but=ded/listeFactureFournisseur.jsp<%=suivant%>&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 // pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
        if(pazy<nbPage){
     %>
     <a href="<%=lien%>?but=ded/listeFactureFournisseur.jsp<%=suivant%>&pazy=<%=pazy+1%>">Page
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