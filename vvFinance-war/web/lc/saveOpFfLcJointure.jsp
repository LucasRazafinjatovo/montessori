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
		 String   liste=null;
                 String acte=null;
                 String idUnion=null;
%>
<%
try
{
  idUnion=request.getParameter("idUnion");
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet=Constante.getObjetDepense();
	idLcArecup=request.getParameterValues("idLC");
montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";
acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="save";

  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
  montant=new String[idLcArecup.length];
  //liste=new UnionIntraTable[idLcArecup.length];
 for (int i=0;i<idLcArecup.length;i++)
 {
 	String ref=null;
 	montant[i]=request.getParameter("montant"+i);
         if((montant[i]==null)||(montant[i].compareToIgnoreCase("")==0))montant[i]="0";
 }
 u.mapperOpFactureFournisseurLCTableau(numObjet, idLcArecup, "-", montant);



 //if(acte.compareToIgnoreCase("svalide")==0)
  //u.validerMappageLCM(Constante.getTableFactureFLC(),ref);
 %>
<script language="JavaScript"> document.location.replace("<%=lien %>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=numObjet%>&avecOp=<%=request.getParameter("avecOp")%>"); </script>
<%
}
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>

