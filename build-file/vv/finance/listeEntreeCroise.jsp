<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/listeEntreeCroise.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet te[] = null;
  TypeObjet dev[] = null;
  facture.Client clt[] = null;
  TypeObjet mp[] =null;
  Caisse caiss[] = null;
  Entree entree[] = null;
  Entree entreePage[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  historique.MapUtilisateur ut=null;
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     dev = u.findTypeObjet("Devise","%","%");
     caiss = u.findCaisse("%","%","%","%");
     ut=u.getUser();
%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new Entree());
  //client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
 // idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  //agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
 // devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  //parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
  numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
 // numero=request.getParameter("numero");if ((numero==null)||numero.compareTo("")==0) numero="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  //idModePaiement=request.getParameter("idModePaiement");
  //if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
    projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";

  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
  entree = u.findEntreeLettre("%", dateDebut, dateFin, "%", "%","%", "%",numPiece, "%", caisse, "eta2","%","%",colonne,ordre,projet, partenaire, apresW);//n'affiche que les entrees crees seulement, n'affiche pas le annulees
  }
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les recettes</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date d&eacute;but :</td>
            <td align="center"><input name="dateDebut" type="text"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle" /></a> </td>
            <td class="left">Date fin:</td>
            <td align="center"><input name="dateFin" type="text"   id="dateFin" value="<%=dateFin%>" size="10" />
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width="16" height="16" border="0" align="absmiddle" /></a> </td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td align="center"><select name="caisse"   id="caisse">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<caiss.length;i++){
 %>
                <option value="<%=caiss[i].getIdCaisse()%>"<%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
   }
 %>
              </select>
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td class="left">Partenaire</td>
            <td align="center"><input name="partenaire" type="text"   id="partenaire" size="10" value="<%=partenaire%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          </tr>
          <tr>
            <td class="left">Num&eacute;ro Entr&eacute;e :</td>
            <td align="center"><input name="numero" type="text"   id="numero" value="<%=numero%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td class="left">Num&eacute;ro Piece:</td>
            <td align="center"><input name="numPiece" type="text"   id="numPiece" value="<%=numPiece%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          </tr>
          <tr>
            <td class="left">Projet :</td>
            <td align="center"><input name="projet" type="text"   id="projet" value="<%=projet%>" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td class="left">&nbsp;</td>
            <td align="center">&nbsp;</td>
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
            <td align="center"><select name="colonne"   id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select>
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"><select name="ordre"   id="select5">
                <option value="ASC" <%if (ordre.compareTo("ASC")==0) out.println("selected");%>>ASC</option>
                <option value="DESC" <%if (ordre.compareTo("DESC")==0) out.println("selected");%>>DESC</option>
              </select>
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"><input type="submit" name="Submit" value="Afficher" class="submit" />
            </td>
            <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" />
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
          <td align="right"><%=Utilitaire.formaterAr((double)AdminEntree.getSommeEntreeByDevise(entree,dev[k].getId()))%> <%=dev[k].getId()%></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><strong> Nb</strong> :<%=AdminEntree.getNombreEntreeByDevise(entree,dev[k].getId())%> </td>
        </tr>
      <%}%>
   </table>
   <br>







   <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="80" height="19" align="center" valign="top">Piece</td>
          <td width="66" align="center" valign="top">Date</td>
          <td width="153" align="right" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant</strong></div></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td width="54" valign="top"></td>
          <%
                }
   %>
        </tr>
        <%
  for(int i=0;i<entree.length;i++){
  %>
        <tr>
          <td align="center"><%=entree[i].getNumpiece()%></td>
          <td align="center"><%=Utilitaire.formatterDaty(entree[i].getDaty())%></td>
          <td align="right"><a href="<%=lien%>?but=finance/detailEntree.jsp&idEntree=<%=entree[i].getIdEntree()%>"><%=entree[i].getDesignation()%></a></td>
          <td align="right"><%=Utilitaire.formaterAr((double)entree[i].getMontant())%><%=" "+entree[i].getIdDevise()%></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td align="center"><a href="<%=lien%>?but=finance/apresEntree.jsp&acte=ANNULER&idEntree=<%=entree[i].getIdEntree()%>">Ann</a></td>
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
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
