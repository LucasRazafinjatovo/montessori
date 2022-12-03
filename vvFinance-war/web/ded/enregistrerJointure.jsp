<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<link href="style.css" rel="stylesheet" type="text/css">


<%!
        UserEJB u 			= null;
		String apres = "ded/apresVisualiserJointure.jsp";
		String lien  		=null;

		 String numObjet=null;
		  String montantObjet=null;
		  String typeObjet=null;//Pour savoir si la table jointure

		 String[] numObjetJ=null;
		  String[] montantObjetJ=null;
		   String typeObjetJ=null;

		 String tableJointure = null;

		 String[] montant=null;
		 UnionIntraTable[] liste=null;
                 String acte=null;
				 String type

%>
<%
try
{
// Saisie numObjet de l'objet mère et le type objet
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet=Constante.getObjetDepense();
montantObjet = request.getParameter("montantObjet");

//Saisie de l'objet fils (tableau)
	numObjetJ=request.getParameterValues("numObjetJ");
montantObjetJ=request.getParameterValues("montantObjetJ");
typeObjetJ=request.getParameter("typeObjetJ");

acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="save";

  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");

tableJointure=request.getParameterValues("tableJointure");

/*if ((tableJointure==null)||tableJointure.compareTo("")==0){

if((typeObjetJ.compareToIgnoreCase(Constante.getObjetLcDetail())==0)&&(typeObjet.compareToIgnoreCase(Constante.getObjetDed())==0))//Lc detail----ded
	{
         tableJointure=Constante.getLcDetailDed();//prendre la table lcDetailDed
	}

	if((typeObjetJ.compareToIgnoreCase(Constante.getObjetLcDetail())==0)&&(typeObjet.compareToIgnoreCase(Constante.getObjetMvtCaisse())==0))
	{
         tableJointure=Constante.getLcDetailMvtCaisse(); //table de jointureLcdetailMvtCaisse
	}
	if((typeObjetJ.compareToIgnoreCase(Constante.getObjetLcDetail())==0)&&(typeObjet.compareToIgnoreCase(Constante.getObjetOp())==0))
	{
         tableJointure=Constante.getLcDetailOp();
        }
	if((typeObjetJ.compareToIgnoreCase(Constante.getObjetDed())==0)&&(typeObjet.compareToIgnoreCase(Constante.getObjetBc())==0)
 	{
         tableJointure=Constante.getDedBc();
	}
if((typeObjetJ.compareToIgnoreCase(Constante.getObjetOp())==0)&&(typeObjet.compareToIgnoreCase(Constante.getObjetFacturefounisseur())==0)
 	{
         tableJointure=Constante.getOpFactureFournisseur();
	}
	}*/

	 if(acte.compareToIgnoreCase("save")==0){
		 for (int i=0;i<numObjetJ.length;i++)
		 {
			String ref=null;

				ref=u.mapperMereFille(tableJointure,numObjetJ[i],numObjet,"-",montantObjetJ[i],montantObjet);

		 }
 }
  if(acte.compareToIgnoreCase("svalide")==0)
   for (int i=0;i<numObjetJ.length;i++)
		 {
			String ref=null;

				ref=u.mapperMereFille(tableJointure,numObjetJ[i],numObjet,"-",montantObjetJ[i],montantObjet);

		 }
            u.validerMappageAvecControle(tableJointure,numObjet,montantObjet);
}
 if(acte.compareToIgnoreCase("valide")==0){
 String [] idMapage= request.getParameterValues("idMapage");
  for (int i=0;i<idMapage.length;i++)
		  u.validerMappage(tableJointure,idMapage[i]);
 }
%>
<script language="JavaScript"> document.location.replace("<%lien%>?but=ded/visualiserJointure.jsp&typeObjet=<%=typeObjet%>&typeObjetJ=<%=typeObjetJ%>&tableJointure=<%=tableJointure%>&numObjet=<%=numObjet%>&montantObjet=<%=montantObjet%>"); </script>
<%



catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
