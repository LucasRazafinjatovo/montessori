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

  String numObjet=null;
  String typeObjet = null;

%>
<%out.println("apres facture");
  acte=request.getParameter("acte");
  out.println("acte = "+acte);
  try
  {
    lien=(String)session.getValue("lien");
    u=(UserEJB)session.getAttribute("u");
    nature=request.getParameter("nature");
    numObjet=request.getParameter("numObjet");
    typeObjet = request.getParameter("typeObjet");

    if (acte.compareTo("INSERT")==0)
    {
      if(typeObjet.compareTo(Constante.getObjetOp())==0){
        u.createMvtCaisseDepense(request.getParameter("daty"),"",request.getParameter("designation"), request.getParameter("debit"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),"1", request.getParameter("numObjet"));
      }else{
        u.createMvtCaisseRecette(request.getParameter("daty"),"",request.getParameter("designation"), request.getParameter("credit"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),request.getParameter("typeMvt"), request.getParameter("numObjet"));
      }
      //out.println("daty sdf"+request.getParameter("dateemission"));
    }
      if (acte.compareTo("retour")==0)
      {
        if(typeObjet.compareTo(Constante.getObjetOp())==0){
          u.createMvtCaisseDepenseRetour(request.getParameter("daty"),"",request.getParameter("designation"), request.getParameter("debit"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),"2", request.getParameter("numObjet"),request.getParameter("idMvt"));
        }
        else{
          u.createMvtCaisseRecette(request.getParameter("daty"),"",request.getParameter("designation"), request.getParameter("credit"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),request.getParameter("typeMvt"), request.getParameter("numObjet"));
        }
%>
          <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeMvtCaisse.jsp");
    </script>
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



