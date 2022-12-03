<%@page import="affichage.Page"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="stock.*" %>
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
	String numObjet = null;
	boolean isLC=false;
	String lc;
	%>
	<%
	out.println("apres facture");
	acte="";
	acte=request.getParameter("acte");
    try{
        lien=(String)session.getValue("lien");
        u=(UserEJB)session.getAttribute("u");
        nature=request.getParameter("nature");
        numObjet =request.getParameter("numObjet");
		lc=request.getParameter("lc");
		isLC=((lc!=null)&&lc.startsWith("LC"));
		if (acte.compareTo("UPDATE")==0)
                {
                    rep = u.modifEntryFactureFseur(request.getParameter("id"),request.getParameter("numFact"),request.getParameter("designation"),request.getParameter("daty"), request.getParameter("fournisseur"),request.getParameter("tva"), request.getParameter("montantTTC"), request.getParameter("remarque"),request.getParameter("dateemission"),request.getParameter("datyecheance"), request.getParameter("idDevise"),request.getParameter("nature"));
			
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/modifierGen.jsp&numObjet=<%=rep%>&nature=FactureFournisseur&tableDet=detailFPF"); </script>
                        <%
		}
		if (acte.compareTo("INSERT")==0)
		{
			rep = u.createEntryFactureFseur(request.getParameter("numFact"),request.getParameter("designation"),request.getParameter("daty"), request.getParameter("fournisseur"),request.getParameter("tva"), request.getParameter("montantTTC"), request.getParameter("remarque"),request.getParameter("dateemission"),request.getParameter("datyecheance"), request.getParameter("idDevise"),request.getParameter("nature"));
			if(isLC==true)
			{
				u.mapperFactureFournisseurLC(rep, lc, "mappage Auto", request.getParameter("montantTTC"));
				%>
				<script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/apresChoixListeLC.jsp&numObjet=<%=rep%>");
                </script>
				<%
            }
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=<%=request.getParameter("nature")%>");</script>
			<%
		}
        if(acte.compareTo("INSERT2")==0){
			rep = u.createEntryFacture(request.getParameter("numFact"),request.getParameter("designation"),request.getParameter("daty"), request.getParameter("fournisseur"),request.getParameter("tva"), request.getParameter("montantTTC"), request.getParameter("remarque"),request.getParameter("dateemission"),request.getParameter("idDevise"),request.getParameter("nature"));
			
			if(isLC==true){
				u.mapperFactureFournisseurLC(rep, lc, "mappage Auto", request.getParameter("montantTTC"));
              %>
              <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/apresChoixListeLC.jsp&numObjet=<%=rep%>");</script>
              <%
			}
			if(request.getParameter("idBL").compareTo("")!=0 || request.getParameter("idBL")!=null){
				ArticleBL[] listelc = ArticleBL.getNumLC(request.getParameter("idBL"));
                                System.out.println(" liste LC = " + listelc.length);
                for(int i = 0; i < listelc.length; i++){
					u.mapperFactureFournisseurLC(request.getParameter("remarque"), listelc[i].getLcunique(), "mappage Auto", listelc[i].getPrixunitaire()+"");
                }
			}
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=stock/listeLcChoix.jsp&idBL=<%=request.getParameter("idBL")%>&numObjet=<%=rep%>&montantObjet=<%=request.getParameter("montantTTC")%>");</script>
			<%
		}
		if (acte.compareTo("VISER")==0)
		{
			rep=u.viserFactureF(request.getParameter("numFact"), request.getParameter("remarque"));
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFacture.jsp&nature=<%=request.getParameter("nature")%>");</script>
			<%
		}
		if (acte.compareTo("INSERTF")==0)
		{
			rep=u.createFournisseur(request.getParameter("fournisseur"),request.getParameter("nif"), request.getParameter("stat"), request.getParameter("tel"), request.getParameter("email"),request.getParameter("adresse"));
            %>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFournisseur.jsp");
                  </script>
			<%
        }
		if (acte.compareTo("CLOTURER")==0)
		{
			out.println("Cloture = "+request.getParameter("idf"));
			rep=u.cloturerFactureFournisseur(request.getParameter("idf"),request.getParameter("numFact"),request.getParameter("designation"),request.getParameter("daty"), request.getParameter("fournisseur"), request.getParameter("montantHT"), request.getParameter("tva"), request.getParameter("montantTTC"), request.getParameter("remarque"),request.getParameter("etat"),request.getParameter("projet"),request.getParameter("dateemission"),request.getParameter("idDevise"));
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/entreeFournisseur.jsp");
                  </script>
			<%
		}
		if (acte.compareTo("VIRER")==0)
		{                          //String daty,          String caisse1,                      String caisse2,                   	String montant,    String remarque, String devise, String mode
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
          if (acte.compareTo("vlc")==0)
          {
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=lc/apresChoixListeLC.jsp&numObjet=<%=request.getParameter("numFact")%>"); </script>
        <%
          }
          if (acte.compareTo("UPDATE")==0)
          {
                  System.out.println("UPDATE");
        //methode update
                
           %>
                  <script language="JavaScript"> document.location.replace("<%=lien%>?but=facturefournisseur/modifierGen.jsp&numObjet=<%=lien%>&nature=FactureFournisseur&tableDet=detailFPF"); </script>
        <%
          }


        }catch (Exception e){
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
                <%
                e.printStackTrace();
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




