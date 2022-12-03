<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="java.sql.Date" %>
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
				if (acte.compareToIgnoreCase("reporter")==0){
					String exo = request.getParameter("exercice");
					Date daty = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty"));
					u.reporter(exo, daty);
				}
				if (acte.compareToIgnoreCase("clotureExercice")==0){
					String exo = request.getParameter("exercice");
					Date daty = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty"));
					u.cloturerEtReporter(exo, daty);
				}
				if(acte.compareToIgnoreCase("visa-ecriture")==0){
					String numE = request.getParameter("numero");
					u.viserEcriture(numE);
				}
				if(acte.compareToIgnoreCase("visamultiple-ecriture")==0){
					String[] lsitepub = request.getParameterValues("id");
					u.viserMultipleEcriture(lsitepub);
				}
				if(acte.compareToIgnoreCase("lettrer-ecriture")==0){
					String[] lsitepub = request.getParameterValues("id");
					u.lettrerEcriture(lsitepub);
				}
				if(acte.compareToIgnoreCase("extourne-ecriture")==0){
					String numE = request.getParameter("numero");
					u.extournerEcriture(numE);
				}
				if(acte.compareToIgnoreCase("update-Ecriture")==0)
                {
					int nbre=Utilitaire.stringToInt(request.getParameter("nbrLigne"));
					int taille=Utilitaire.stringToInt(request.getParameter("taille"));
					int tailleInit = Utilitaire.stringToInt(request.getParameter("tailleInit"));
					int numero = Utilitaire.stringToInt(request.getParameter("numero"));
					
					Date datyR = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty"));
					String societeR = request.getParameter("idsociete");
					String journalR = request.getParameter("journal");	
					
					Date daty[] = new Date[nbre];
					String societe[] = new String[nbre];
					String journal[] = new String[nbre];
					String numpiece[] = new String[nbre];
					String compte[] = new String[nbre];
					String tiers[] = new String[nbre];
					Date echeance[] = new Date[nbre];
					String libelle[] = new String[nbre];
					double montantdebit[] = new double[nbre];
					double montantcredit[] = new double[nbre];
					String id[] = new String[tailleInit];
					int tailletemp = 0;
					for (int i=0; i<taille; i++){
						int index = i+1;
						if (tailletemp < nbre && request.getParameter("libelle_"+index) != null){
							if (tailletemp < tailleInit) {
								id[tailletemp] = request.getParameter("id_"+index);
							}
							daty[tailletemp] = datyR;
							societe[tailletemp] = societeR;
							journal[tailletemp] = journalR;
							numpiece[tailletemp] = request.getParameter("numpiece_"+index);
							compte[tailletemp] = request.getParameter("compte_"+index);
							tiers[tailletemp] = request.getParameter("tiers_"+index);
							if (request.getParameter("echeance_"+index).compareTo("") != 0 ){
								echeance[tailletemp] = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("echeance_"+index));
							}
							else echeance[tailletemp] = null;
							libelle[tailletemp] = request.getParameter("libelle_"+index);
							montantdebit[tailletemp] = Utilitaire.stringToDouble(request.getParameter("montantdebit_"+index));
							montantcredit[tailletemp] = Utilitaire.stringToDouble(request.getParameter("montantcredit_"+index));
							Ecriture ecriture = new Ecriture(daty[tailletemp], societe[tailletemp], journal[tailletemp], numpiece[tailletemp],
								compte[tailletemp], tiers[tailletemp], echeance[tailletemp], libelle[tailletemp], montantdebit[tailletemp], montantcredit[tailletemp]);
							tailletemp++;
						}
						if (tailletemp == nbre) break;
					}
                    u.updateMultipleEcriture(daty, societe, journal, numpiece, compte, tiers, echeance, libelle, montantcredit, montantdebit, id, numero, tailleInit);
					
                }
                if(acte.compareToIgnoreCase("ouvrirExercice")==0)
                {
                        t = (ClassMAPTable)(Class.forName(classe).newInstance());
						Exercice exerc = (Exercice) t;
						exerc.ouvrir();
                        PageInsert p = new PageInsert(exerc,request);
                        ClassMAPTable f = p.getObjectAvecValeur();
                        u.createObject(f);
                }
				if(acte.compareToIgnoreCase("insertmultiple-Ecriture")==0 || acte.compareToIgnoreCase("declarer")==0)
                {
					int taille=Utilitaire.stringToInt(request.getParameter("nbrLigne"));
					int nbre=Utilitaire.stringToInt(request.getParameter("taille"))-1;
										
					Date daty[] = new Date[taille];
					String societe[] = new String[taille];
					String journal[] = new String[taille];
					String numpiece[] = new String[taille];
					String compte[] = new String[taille];
					String tiers[] = new String[taille];
					Date echeance[] = new Date[taille];
					String libelle[] = new String[taille];
					double montantdebit[] = new double[taille];
					double montantcredit[] = new double[taille];
					int tailletemp = 0;
					
					Date datyR = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("daty"));
					String societeR = request.getParameter("idsociete");
					String journalR = request.getParameter("journal");
					
					for (int i=0; i<nbre; i++){
						int index = i+1;
						if (tailletemp < taille && request.getParameter("libelle_"+index) != null){
							daty[tailletemp] = datyR;
							societe[tailletemp] = societeR;
							journal[tailletemp] = journalR;
							numpiece[tailletemp] = request.getParameter("numpiece_"+index);
							compte[tailletemp] = request.getParameter("compte_"+index);
							tiers[tailletemp] = request.getParameter("tiers_"+index);
							if (request.getParameter("echeance_"+index).compareTo("") != 0 ){
								echeance[tailletemp] = Utilitaire.string_date("dd/MM/yyyy",request.getParameter("echeance_"+index));
							}
							else echeance[tailletemp] = null;
							libelle[tailletemp] = request.getParameter("libelle_"+index);
							montantdebit[tailletemp] = Utilitaire.stringToDouble(request.getParameter("montantdebit_"+index));
							montantcredit[tailletemp] = Utilitaire.stringToDouble(request.getParameter("montantcredit_"+index));
							Ecriture ecriture = new Ecriture(daty[tailletemp], societe[tailletemp], journal[tailletemp], numpiece[tailletemp],
								compte[tailletemp], tiers[tailletemp], echeance[tailletemp], libelle[tailletemp], montantdebit[tailletemp], montantcredit[tailletemp]);
							tailletemp++;
						}
						if (tailletemp == taille) break;
					}
					
                    int numE = u.insertMultipleEcriture(daty, societe, journal, numpiece, compte, tiers, echeance, libelle, montantcredit, montantdebit);
					if(acte.compareToIgnoreCase("declarer")==0){
						u.viserEcriture(Integer.toString(numE));
						String debitD = request.getParameter("id1");
						String creditD = request.getParameter("id2");
						String debitU = request.getParameter("id3");
						String creditU = request.getParameter("id4");
						u.lettrerDeclaration(numE, debitD, creditD, debitU, creditU);
					}
                }
                if(acte.compareToIgnoreCase("insert")==0) {
                        t = (ClassMAPTable)(Class.forName(classe).newInstance());
                        PageInsert p = new PageInsert(t,request);
                        ClassMAPTable f = p.getObjectAvecValeur();
                        u.createObject(f);
                }
				
                if(acte.compareToIgnoreCase("delete")==0)
                {
                        t=(ClassMAPTable)(Class.forName(classe).newInstance());
                        t.setValChamp(t.getAttributIDName(),request.getParameter("id"));
                        u.deleteObject(t);
                }
                if(acte.compareToIgnoreCase("update")==0)
                {
                        t = (ClassMAPTable)(Class.forName(classe).newInstance());
                        Page p = new Page(t,request);
                        ClassMAPTable f = p.getObjectAvecValeur();
                        u.updateObject(f);
                }
                if(acte.compareToIgnoreCase("annulerOP")==0){
                        String idop = request.getParameter("id");
                        String designation = request.getParameter("remarque");
                        u.annulerOP(idop, designation);
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



