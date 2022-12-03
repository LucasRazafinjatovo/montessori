<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/croiseEntree.jsp";
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
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire;
  String colonne,ordre;
  String [] nomCol=null;
  String [] listeCentre=null;
  String designation=null;
  String agence=null;
  String parution=null;

     %>
<%
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
  client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
// devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
  numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
  numero=request.getParameter("numero");if ((numero==null)||numero.compareTo("")==0) numero="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  idModePaiement=request.getParameter("idModePaiement"); if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
  listeCentre=Utilitaire.getNomColonne(new Entree(),"nombre");
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
            <td class="left">Date début :</td>
            <td align="center"> <input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10">
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"> <input name="dateFin" type="text" class="champ" id="dateFin" value="<%=dateFin%>" size="10">
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">Designation :</td>
            <td align="center"> <input name="designation" type="text" class="champ" value="<%=designation%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Type :</td>
            <td align="center"> <select name="idType" class="champ" id="idType">
                <option value="%">Tous</option>
                <%
   for(int i= 0;i<te.length;i++){
  %>
                <option value="<%=te[i].getId()%>" <%if(te[i].getId().compareTo(idType)==0)out.println("selected");%>><%=te[i].getDesce()%></option>
                <%
       }
  %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td align="center"> <select name="caisse" class="champ" id="caisse">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<caiss.length;i++){
 %>
                <option value="<%=caiss[i].getIdCaisse()%>"<%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Source</td>
            <td align="center"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getVal()%> <%if(mp[i].getVal().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Num&eacute;ro Entr&eacute;e :</td>
            <td align="center"> <input name="numero" type="text" class="champ" id="numero" value="<%=numero%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Num&eacute;ro Piece:</td>
            <td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece" value="<%=numPiece%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Agence :</td>
            <td align="center"> <input name="agence" type="text" class="champ" id="agence" value="<%=agence%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Parution :</td>
            <td align="center"> <input name="parution" type="text" class="champ" id="parution" value="<%=parution%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">client :</td>
            <td align="center"> <input name="agence" type="text" class="champ" id="agence" value="<%=agence%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left" > &nbsp; </td>
            <td class="left" > &nbsp; </td>
            </td>
          </tr>
      </table></td>
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
            <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("idProjet")==0) out.println("selected");%>><%=nomCol[i]%></option>
            <%
   }
 %>
          </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
          <td class="left"><div align="center">Ligne :</div></td>
          <td align="center"><select name="nomLigne"   id="select2">
            <%
   for(int i=0;i<nomCol.length;i++){
 %>
            <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("idModePaiement")==0) out.println("selected");%>><%=nomCol[i]%></option>
            <%
   }
 %>
          </select>  &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
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
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
          </tr>
        </table>
		</td>
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
