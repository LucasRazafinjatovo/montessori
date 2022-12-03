<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.*" %>
<%@ page import="prevision.*" %>
<%@ page import="finance.*" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
  UserEJB u = null;
  String acte=null;
  String lien=null;
  String bute;
%>
<%
  try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  acte=request.getParameter("acte");
  bute=request.getParameter("bute");
  String[]rajoutLien=null;
  String tempRajout=request.getParameter("rajoutLien");
  String tableBdd=request.getParameter("tableBdd");
  if(tempRajout!=null&&tempRajout.compareToIgnoreCase("")!=0)
  {
    rajoutLien=utilitaire.Utilitaire.split(tempRajout,"-");
  }
  if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/Pub.jsp";

  String classe=request.getParameter("classe");
  String idcaisse=(String)session.getAttribute("idcaisse");
  ClassMAPTable t=null;
  String idreleve[]=(String [])request.getParameterValues("manuelr");
  String idgl[]=(String [])request.getParameterValues("manuelgl");
  if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";
                if(acte.compareToIgnoreCase("rapprocher")==0){
                   if(idreleve!=null && idgl!=null)
                   {
                    u.rapprocher(idreleve, idgl,idcaisse);
                   }
                   else
                   {
                       throw new Exception("Vous Devez cocher les élements à rapprocher");
                   }
               } 
		if(acte.compareToIgnoreCase("rapprocherAuto")==0){
                    if(idcaisse!=null)
                    {
                        u.rapprochementAutomatique(idcaisse);
                    }
                    else
                   {
                       throw new Exception("Vous Devez selectionner un caisse");
                   }
                } 		
                String rajoutLie="";
                if(rajoutLien!=null)
                {
                        for(int o=0;o<rajoutLien.length;o++)
                        {
                                String valeur = request.getParameter(rajoutLien[o]);
                                rajoutLie=rajoutLie+"&"+rajoutLien[o]+"="+valeur;
                        }
                }
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+rajoutLie%>"); </script>
                <%
        }catch (Exception e){
                e.printStackTrace();
           %>
                        <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
            <%
                return;
        }
        %>
</html>



