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
  TypeObjet te[] = null;
  TypeObjet dev[] = null;

  facture.Client clt[] = null;
  TypeObjet mp[] =null;
  Caisse caiss[] = null;
  String numPiece=null;
  String numero=null;
  historique.MapUtilisateur ut=null;
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire,etat,fournisseur,apresW,fg;
  String colonne,ordre;
  String [] nomCol=null;

     %>
<%
     u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
          //caiss = u.findCaisse("%","%","%","%");
        /*   for(int i=0;i<caiss.length;i++){
         out.println (caiss[i].getIdCaisse()+" - "+caiss[i].getDescCaisse());
       }*/

    te = u.findTypeObjet("TypeEntree","%","%");

        Utilitaire utilitR=new Utilitaire();
     ut=u.getUser();
%>
<%
  try{

  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";

        projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
        etat=request.getParameter("etat");if ((etat==null)||etat.compareTo("")==0) etat="%";
    fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";

         nomCol=Utilitaire.getNomColonne(new FactureFournisseur());
 apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
        // nomCol=Utilitaire.getNomColonne(new Entree());

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
            <td class="left">Date début :</td>
            <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a>
            </td>
          </tr>
          <tr>
            <td class="left">Fournisseur :</td>
            <td align="center"><input name="fournisseur" type="text" class="champ"   id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" />
            &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">Projet</td>
            <td align="center"><input name="projet" type="text" class="champ"   id="projet" value="<%=projet%>"size="10" maxlength="10" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
          </tr>
          <tr>
            <td class="left">Designation :</td>
            <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="%" />
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" />
            </td>
            <td class="left">id Fact </td>
            <td align="center"><input name="idFact" type="text" class="champ"   id="idFact" value="%"size="10" maxlength="10" /></td>
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
            <td align="center">  <select name="colonne"   id="select4">
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



<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
