<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/croiseSortie.jsp";
        String lien= null;
        UserEJB u = null;
        String client=null;
        Caisse caiss[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet te[] = null;
        String idType = null;
        String caisse=null;
        String idModePaiement = null;
        String idDevise = null;
        String dateDebut=null;
        String dateFin=null;
        historique.MapUtilisateur ut=null;
		String projet, partenaire, facture;
  		String [] nomCol=null;
  		String [] listeCentre=null;

%>
<%
	nomCol=Utilitaire.getNomColonne(new Sortie());
	listeCentre=Utilitaire.getNomColonne(new Sortie(),"nombre");
  	//client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
  	//idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  	caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  	idModePaiement=request.getParameter("idModePaiement");if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  	dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
	dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
	projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
    partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
    facture=request.getParameter("facture");if ((facture==null)||facture.compareTo("")==0) facture="%";
	for(int i=0;i<nomCol.length;i++){

            System.out.println("eeeeeeee"+nomCol[i]);

   }
%>
<%

try{
//(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat)
  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  mp = u.findTypeObjet("Beneficiaire","%","%");
  te = u.findTypeObjet("TypeSortie","%","%");
  caiss = u.findCaisse("%","%","%","%");
  dev = u.findTypeObjet("Devise","%","%");
  ut=u.getUser();

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les d&eacute;penses</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les d&eacute;penses)</p>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeDepense" id="listeDepense">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td> <input name="datyInf" type="text" class="champ" id="datyInf" value="<%=dateDebut%>" size="10" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin:</td>
            <td> <input name="datySup" type="text" class="champ" id="datySup" value="<%=dateFin%>" size="10">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <input name="designation" type="text" class="champ" id="designation" ></td>
            <td class="left">Projet :</td>
            <td> <input name="projet" type="text" class="champ" id="projet" size="10"></td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td ><select name="caisse" class="champ">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<caiss.length;i++){
          %>
                <option value=<%=caiss[i].getIdCaisse()%> <%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.print("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
                }
                %>
              </select></td>
            <td class="left">Facture : </td>
            <td> <input name="facture" type="text" class="champ" id="facture" size="10"> </td>
          </tr>
          <tr>
            <td class="left">Partenaire :</td>
            <td align="center"> <div align="left">
                <input name="partenaire" type="text" class="champ" id="partenaire" value="%">
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
            <td class="left">Numéro :</td>
            <td align="center"> <div align="left">
                <input name="idDepense" type="text" class="champ" id="idDepense" value="%">
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td><select name="idType" class="champ" id="idType">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<te.length;i++){
          %>
                <option value="<%=te[i].getId()%>"><%=te[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
            <td class="left">Bénéficiaire :</td>
            <td align="center"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getTuppleID()%> <%if(mp[i].getTuppleID().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>

        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><strong><font color="#FF0000" size="+1">CROISER
        PAR </font></strong></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Col :</td>
            <td align="center"><select name="colonne"   id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("source")==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select>
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td class="left"><div align="center">Ligne :</div></td>
            <td align="center"><select name="nomLigne"   id="select2">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("idTypeEntree")==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select>
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
            <td align="center"><strong>Centre: </strong></td>
            <td align="center"><select name="centre"   id="select">
                <%
   for(int i=0;i<listeCentre.length;i++){
 %>
                <option value="<%=listeCentre[i]%>"><%=listeCentre[i]%></option>
                <%
   }
 %>
            </select></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>


<script language="JavaScript">
var cal1 = new calendar1(document.forms['listeDepense'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeDepense'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>





