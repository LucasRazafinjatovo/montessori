<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<link href="style.css" rel="stylesheet" type="text/css">


<%!
        UserEJB u 			= null;
		String lien  		=null;
		 String numObjet=null;
		 String typeObjet=null;
		  String montantObjet=null;
		 String[]idLcArecup=null;
		 String[] montant=null;
		 UnionIntraTable[] liste=null;
                 String acte=null;String nature2=null;
%>
<%
try
{
  nature2=request.getParameter("nature2");if ((nature2==null)||nature2.compareTo("")==0) nature2="ded";
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet=Constante.getObjetDepense();
	idLcArecup=request.getParameterValues("idLC");
montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";
acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="save";
String nomTableAssociation=new AssociationTableUtil().findAssociationTable("%",nature2,typeObjet,"%","%","%")[0].getTUnion();

  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
  montant=new String[idLcArecup.length];
  liste=new UnionIntraTable[idLcArecup.length];
 for (int i=0;i<idLcArecup.length;i++)
 {
 	String ref=null;
 	montant[i]=request.getParameter("montant"+i);
        if((acte.compareToIgnoreCase("ventileGroupe")!=0)&&(acte.compareToIgnoreCase("ventileValideGroupe")!=0))
        {
          ref=u.mapperMereFille(nomTableAssociation,idLcArecup[i],numObjet,"-",montant[i],montantObjet);
        }
        else
        {
          ref=u.ventilerMvtCaisseLcDetailDepenseGroupe(idLcArecup[i], numObjet, "-", montant[i]);
        }
 }
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>&nature2=<%=nature2%>"); </script>
<%
 if(acte.compareToIgnoreCase("svalide")==0)
 {
            u.validerMappageAvecControle(nomTableAssociation,numObjet,montantObjet);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>"); </script>
<%
 }
 if(acte.compareToIgnoreCase("ventileValideGroupe")==0)
 {
            u.validerMvtCaisseLcDetailDepenseGroupe(numObjet);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserDedJointure.jsp&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>"); </script>
<%
 }
}
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>