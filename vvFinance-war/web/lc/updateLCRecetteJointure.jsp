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
                 int nb=0;
%>
<%
try
{
  nb=Utilitaire.stringToInt(request.getParameter("nb"));
  montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";
  acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="update";
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  idUnion=request.getParameter("idUnion");
lien	= (String)session.getValue("lien");
u		= (UserEJB)session.getAttribute("u");
montant=new String[nb];
idLcArecup=new String[nb];
for (int i=0;i<idLcArecup.length;i++)
{
   idLcArecup[i]=request.getParameter("idLC"+i);
   montant[i]=request.getParameter("montant"+i);
   if((montant[i]==null)||(montant[i].compareToIgnoreCase("")==0))montant[i]="0";
 }

  if(acte.compareToIgnoreCase("update")==0) u.updateMontantUnionIntra(Constante.tableFactureCLC,numObjet,idLcArecup,montant);
  if(acte.compareToIgnoreCase("delete")==0) u.deleteUnionIntraTable(Constante.tableFactureCLC,idUnion);
  if(acte.compareToIgnoreCase("svalide")==0)
  {
  	//if((request.getParameter("avecOp")==null)||(request.getParameter("avecOp").compareToIgnoreCase("null")==0))
     u.validerMappageLCMRecette(Constante.tableFactureCLC,numObjet);
	//else u.validerMappageLCMavecOp(Constante.getTableFactureFLC(),numObjet,request.getParameter("avecOp"));
}
 %>
<script language="JavaScript"> document.location.replace("<%=lien %>?but=lc/apresChoixListeLCRecette.jsp&numObjet=<%=numObjet%>&avecOp=<%=request.getParameter("avecOp")%>"); </script>
<%
}
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>

