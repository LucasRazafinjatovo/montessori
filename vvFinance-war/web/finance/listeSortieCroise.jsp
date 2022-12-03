<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/listeSortieCroise.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet te[] = null;
  TypeObjet dev[] = null;
  facture.Client clt[] = null;
  TypeObjet mp[] =null;
  Caisse caiss[] = null;
  Sortie sortie[] = null;
  Sortie sortiePage[] = null;
  //String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  historique.MapUtilisateur ut=null;
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire, facture;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;
  String listeCentre[]=null;
  double sommeSortie=0;
  ObjetCroise oc=null;
  String apresW=null;
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     te = u.findTypeObjet("TypeSortie","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     dev = u.findTypeObjet("Devise","%","%");
     caiss = u.findCaisse("%","%","%","%");
     ut=u.getUser();
%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new Sortie());
  listeCentre=Utilitaire.getNomColonne(new Sortie(),"nombre");
  //client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
  //idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  //agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
  devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  //parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
    colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
   ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  idModePaiement=request.getParameter("idModePaiement");
  if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
    partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
    facture=request.getParameter("facture");if ((facture==null)||facture.compareTo("")==0) facture="%";
     //public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String apresW)

  sortie = u.findSortieLettre( "%",dateDebut, dateFin, "%","%", "%","%", "%", caisse, "eta2","%","%","montant","DESC",projet, partenaire, facture,apresW);//n'affiche que les sorties crees seulement, n'affiche pas le annulees
}

 catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les depenses crois&eacute;es </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeDepense" id="listeDepense">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date d&eacute;but :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=dateDebut%>" size="10" maxlength="10" />
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle" /></a></td>
            <td class="left">Date fin:</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=dateFin%>" size="10" />
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle" /></a></td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation :</td>
            <td><input name="designation" type="text" class="champ" id="designation" /></td>
            <td class="left">Projet :</td>
            <td><input name="projet" type="text" class="champ" id="projet" size="10" /></td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td ><select name="caisse" class="champ">
                <option value="%">Tous</option>
                <%
	  for(int i=0;i<caiss.length;i++){
	  %>
                <option value="<%=caiss[i].getIdCaisse()%>" <%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.print("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
		}
		%>
            </select></td>
            <td class="left">Facture : </td>
            <td><input name="facture" type="text" class="champ" id="facture" size="10" />
            </td>
          </tr>
          <tr>
            <td class="left">Partenaire :</td>
            <td align="center"><div align="left">
                <input name="agence" type="text" class="champ" id="agence" value="%" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </div></td>
            <td class="left">Fournisseur :</td>
            <td align="center"><div align="left">
                <input name="parution" type="text" class="champ" id="parution" value="%" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </div></td>
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
            <td align="center"> <select name="colonne" class="champ" id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="select5">
                <option value="ASC" <%if (ordre.compareTo("ASC")==0) out.println("selected");%>>ASC</option>
                <option value="DESC" <%if (ordre.compareTo("DESC")==0) out.println("selected");%>>DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>

        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>


</form>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">

        <%
    for(int k=0;k<dev.length;k++)
    {
    %>
        <tr class="head">
          <td width="123"  height="25" align="center" bgcolor="#C300FF"><div align="right"><strong><%=dev[k].getVal()%></strong></div></td>
          <td width="153" align="right">&nbsp;</td>
          <td width="69" align="center">
            <div align="right"></div></td>
          <td width="138" align="center">
            <div align="right"></div></td>
          <td width="113" align="center"><strong> </strong></td>
        </tr>
        <tr>
          <td  height="25" align="left"><div align="right">&nbsp;<strong>Total
              <%=dev[k].getVal()%> :</strong></div></td>
          <td align="right"><%=Utilitaire.formaterAr((double)AdminSortie.getSommeSortieByDevise(sortie,dev[k].getId()))%> <%=dev[k].getId()%></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><strong> Nb</strong> :<%=AdminSortie.getNombreSortieByDevise(sortie,dev[k].getId())%> </td>
        </tr>
      <%}%>
   </table>
   <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="80" height="19" align="center" valign="top">Piece</td>
          <td width="66" align="center" valign="top">Date</td>
          <td width="153" align="right" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant</strong></div></td>
          <td width="102" align="center" valign="top">Agence</td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>

          <%
                }
   %>
        </tr>
        <%
  for(int i=0;i<sortie.length;i++){
  %>
        <tr>
		<td align="center"><%=sortie[i].getIdSortie()%></td>
          <td align="center"><%=Utilitaire.formatterDaty(sortie[i].getDaty())%></td>
          <td align="right"><a href="<%=lien%>?but=finance/detailSortie.jsp&idSortie=<%=sortie[i].getIdSortie()%>"><%=sortie[i].getDesignation()%></a></td>
          <td align="right"><%=Utilitaire.formaterAr((double)sortie[i].getMontant())%><%=" "+sortie[i].getIdDevise()%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td align="center"><a href="<%=lien%>?but=finance/apresSortie.jsp&acte=ANNULER&idSortie=<%=sortie[i].getIdSortie()%>">Ann</a></td>
          <%
                }
          %>
        </tr>
        <%
    }
  %>
      </table>
</td>
</tr>
</table>
<br>
<script language="javascript">
  var cal1 = new calendar1(document.forms['listeDepense'].elements['datyInf']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeDepense'].elements['datySup']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
