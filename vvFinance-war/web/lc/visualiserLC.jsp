<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!
         String apres = "lc/apresVisualiserLC.jsp";

        String lien = null;
        UserEJB u = null;
        LigneCreditComplet l = null;
        String indiceSelection =  null;
	   String numObjet = null;
        String readOnly = "readonly";

               %>
<%
                try {
                u = (user.UserEJB) session.getValue("u");
                lien = (String) session.getValue("lien");
               String indiceSelection=request.getParameter("indice");
                numObjet=request.getParameter("numObjet");
//String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable
				LigneCreditComplet l = u.findLCComplet(numObjet,"","","","","","","","","","idLigne","ASC","","LigneCredit")[0];


        } catch (Exception e) {
          e.printStackTrace();
%>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
  }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Visualiser ligne de credit</h1>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                 <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
	      <tr>
	      <td class="left" width="40%">Id Ligne Crédit:</td>
	      <td><div align="center"><%=l.getIdLigne() %></div></td>
	      </tr>
      	  <tr>
	      <td class="left">Désignation:</td>
	      <td><div align="center"><%=l.getDesignation() %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Type d'utilisation:</td>
	      <td><div align="center"><%=l.getTypeLC() %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Initial:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getCreditInitial()) %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Actuel:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getCreditModifier()) %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Dispo:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getCreditInitial()-l.getMontantEng()) %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Engagé:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getMontantEng())  %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Visa:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getMontantVis()) %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Facturé:</td>
	      <td><div align="center"><%=Utilitaire.formaterAr(l.getMontantFac()) %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Direction:</td>
	      <td><div align="center"><%=l.getLibelledir()+" ("+l.getAbbrevdir()+")" %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Entité:</td>
	      <td><div align="center"><%=l.getEntite() %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Num Compte:</td>
	      <td><div align="center"><%=l.getNumCompte()+ " ("+l.getDescCompte()+")" %></div></td>
	      </tr>
	      <tr>
	      <td class="left">Excercice:</td>
	      <td><div align="center"><%=l.getMois()+ "/"+l.getAnnee() %></div></td>
	      </tr>

	 </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
				  <input type="hidden" name="acte" value="detail" />
				  <input type="hidden"  name="numobjet" value="<%=numObjet%>">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center">


<input type="submit" name="Submit"  class="submit" onClick="acte.value='detail'" value="Creer Detail"></td>
<td align="center"><input type="submit" name="Submit"  class="submit" onClick="acte.value='modif'" value="Modifier LC"></td>

                          </tr>
                  </table>
                  </td>
          </tr>
  </table>
  </form>