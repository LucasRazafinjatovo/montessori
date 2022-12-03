<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
		String type="%";
		String devise="%";
		String caisse="%";
		String datyDeb="";
		String datyFin="";
		String acte=null;
                String lien=null;
%>
<%
lien=(String)session.getValue("lien");
type=request.getParameter("type");if ((type==null)||type.compareTo("")==0) type="%";
devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
acte=request.getParameter("acte");
datyDeb=request.getParameter("datyDeb");
datyFin=request.getParameter("datyFin");

	try
	{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          if (acte.compareTo("ENTREE")==0)
          {
            if (caisse.compareToIgnoreCase("%")!=0) caisse = u.findCaisse(caisse,"%","%","%")[0].getDescCaisse();
            //type=u.findTypeObjet("TypeEntree","%",type)[0].getId();
           %>
 		 <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeEntree.jsp&dateDebut=<%=datyDeb%>&dateFin=<%=datyFin%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&devise=<%=devise%>&idType=<%=type%>"); </script>
        <%
          }
          if (acte.compareTo("SORTIE")==0)
          {
            type=u.findTypeObjet("TypeSortie","%",type)[0].getId();
           %>
 		 <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeSortie.jsp&datyInf=<%=datyDeb%>&datySup=<%=datyFin%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&devise=<%=devise%>&idType=<%=type%>"); </script>
        <%
          }
        }catch (Exception e){
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
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
