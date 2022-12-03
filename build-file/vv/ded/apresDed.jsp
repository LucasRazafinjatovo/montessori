<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree=null;
        String numFact=null;
        String typa=null;
	String nomClient=null;
	String nature=null;

%>
<%out.println("apres facture");
acte=request.getParameter("acte");
out.println("acte = "+acte);
	try
	{
          lien=(String)session.getValue("lien");
           u=(UserEJB)session.getAttribute("u");
		nature=request.getParameter("nature");
          if (acte.compareTo("UPDATE")==0)
          {
          //rep=u.updateEntree(request.getParameter("id"),request.getParameter("date"),request.getParameter("designation"),request.getParameter("montant"),request.getParameter("client"),request.getParameter("idType"),request.getParameter("numPiece"),request.getParameter("idDevise"),request.getParameter("idMode"),request.getParameter("idCaisse"),"cree",request.getParameter("remarque"));
           %>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefourni/listeEntree.jsp&daty1=<%=request.getParameter("daty")%>&daty2=<%=request.getParameter("daty")%>"); </script>
           <%
          }
          if (acte.compareTo("INSERT")==0)
          {
			//out.println("daty sdf"+request.getParameter("dateemission"));
			rep=u.createDed(request.getParameter("designation"),request.getParameter("daty"), request.getParameter("montantTTC"),request.getParameter("tva"),  request.getParameter("remarque"),request.getParameter("fournisseur"),request.getParameter("idLigne"));
			//out.println("fournisseur = "+request.getParameter("fournisseur"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=proformat");
		  </script>
          <%
          }

		  if (acte.compareTo("INSERTF")==0)
          {
			//out.println("daty sdf"+request.getParameter("dateemission"));
			//rep=u.createFournisseur(request.getParameter("fournisseur"),request.getParameter("nif"), request.getParameter("stat"), request.getParameter("tel"), request.getParameter("email"),request.getParameter("adresse"));
			//out.println("fournisseur = "+request.getParameter("fournisseur"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFournisseur.jsp");
		  </script>
          <%
          }

		   if (acte.compareTo("CLOTURER")==0)
          {
			out.println("Cloture = "+request.getParameter("idf"));
			rep=u.cloturerFactureFournisseur(request.getParameter("idf"),request.getParameter("numFact"),request.getParameter("designation"),request.getParameter("daty"), request.getParameter("fournisseur"), request.getParameter("montantHT"), request.getParameter("tva"), request.getParameter("montantTTC"), request.getParameter("remarque"),request.getParameter("etat"),request.getParameter("projet"),request.getParameter("dateemission"),request.getParameter("idDevise"));
			//out.println("fournisseur = "+request.getParameter("fournisseur"));

%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFournisseur.jsp");
		  </script>
          <%
          }

          if (acte.compareTo("VIRER")==0)
          {                          //String daty,          String caisse1,                      String caisse2,                   String montant,    String remarque, String devise, String mode
           // u.virer(request.getParameter("daty"),request.getParameter("caisse1"),request.getParameter("caisse2"),request.getParameter("montant"),request.getParameter("remarque"),request.getParameter("idDevise"),request.getParameter("idModeP"),request.getParameter("typeE"),request.getParameter("typeS"));

%>
          <script language="JavaScript">// document.location.replace("<%=lien%>?but=finance/virer.jsp"); </script>
          <%
          }
          if (acte.compareTo("REPORTER")==0)
          {                          //String daty,                  String datyFin,                   String montant,             String caisse, String devise
          // u.reporter(request.getParameter("daty"),request.getParameter("datyFin"),request.getParameter("montant"),request.getParameter("caisse"),request.getParameter("idDevise"));

%>
          <script language="JavaScript"> //document.location.replace("<%=lien%>?but=finance/reporter.jsp"); </script>
          <%
          }
          if (acte.compareTo("ANNULER")==0)
          {
            retour=u.annulerEntree(idEntree);

           %>
 		 <script language="JavaScript"> //document.location.replace("<%=lien%>?but=finance/critereEntree.jsp"); </script>
        <%
          }
        }catch (Exception e){
 %>

<script language="JavaScript"> ///document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




