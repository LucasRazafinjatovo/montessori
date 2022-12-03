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
  ClassMAPTable t=null;
        if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";
                if(acte.compareToIgnoreCase("ribmultiple")==0)
                {
                  String[] idrib = request.getParameterValues("id");
                  u.rapprochementRIBMultiple(idrib);
                                        %>
                    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>"); </script>
                    <%
						return;
                }
				if(acte.compareToIgnoreCase("mvtmultiple") == 0){
					String[] idrib = request.getParameterValues("id");
					String idmvt = request.getParameter("idmvt");
					u.rapprochementRIBMultiple(idrib, idmvt);%>
                    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>"); </script>
                    <%
					return;
                }
                if(acte.compareToIgnoreCase("ribupdate")==0){
					String idrib = request.getParameter("idrib");

					String[] idmv = Utilitaire.split(request.getParameter("idmvt"),",");
					String listmvt = "";
					for(int i=0;i<idmv.length;i++){
						if(i == 0){
							listmvt = idmv[i]+",";
						}else{
							listmvt += idmv[i]+",";
						}
					}
					u.rapprocherAndUpdateRib(idrib, idmv);
					%>
					<script language="JavaScript">
							document.location.replace("<%=lien%>?but=finance/rapprochementRibEtMvt.jsp&idrib=<%=idrib%>&idmvt=<%=listmvt%>");
					</script>
					<%
					return;
                }
                if(acte.compareToIgnoreCase("payerribc")==0){
                  String listeRib = request.getParameter("req");
                  String remarque = request.getParameter("remarquePaiement");
                  String typeprevu = request.getParameter("typeprevu");
                  String fournisseur = request.getParameter("fournisseur");
                  String dateDePaiement = request.getParameter("dateDePaiement");
                  String typelc = request.getParameter("typelc");
                  String mois = request.getParameter("mois");
                  String annee = request.getParameter("annee");
                  String[] entite = request.getParameterValues("entite");

                  u.payerRibMultiple(listeRib, remarque, typeprevu, fournisseur, dateDePaiement, typelc, mois, annee, entite);
                  %>
                  <script language="JavaScript">document.location.replace("<%=lien%>?but=ded/rib-multiple.jsp");</script>
                  <%
                }
                if(acte.compareToIgnoreCase("saveRib")==0){
                  t = (ClassMAPTable)(Class.forName(classe).newInstance());
                  PageInsert p = new PageInsert(t,request);
                  ClassMAPTable f = p.getObjectAvecValeur();
                  String result = u.rapprocherMvt(f);
                  Rib rib = (Rib)f;
                  if(result.compareToIgnoreCase("") != 0){
                    RapprochementBancaire rappro = u.getDetailRappro(result);
                                        %>
                                        <script language="JavaScript">
                                                document.location.replace("<%=lien%>?but=finance/rapprochementRibEtMvt.jsp&idrib=<%=result%>&idmvt=<%=rappro.getIdmouvement()%>");
                                        </script>
                                        <%
                  }else{
                                        %>
                                        <script language="JavaScript">
                                                document.location.replace("<%=lien%>?but=finance/rib.jsp");
                                        </script>
                                        <%
                  }
                                return;
                }
                else{
                  String idrib = request.getParameter("idrib");
                  String[] idmvt = request.getParameterValues("id");
                  String listmvt = "";
                  for(int i=0;i<idmvt.length;i++){
                    if(i == 0){
                      listmvt = idmvt[i]+",";

                    }else{
                      listmvt += idmvt[i]+",";
                    }
                  }
                                        %>
                                        <script language="JavaScript">
                                                document.location.replace("<%=lien%>?but=finance/rapprochementRibEtMvt.jsp&idrib=<%=idrib%>&idmvt=<%=listmvt%>");
                                        </script>
                                        <%
                                        return;
                }

        }catch (Exception e){
                e.printStackTrace();
           %>
                        <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
            <%
        }
        %>
</html>



