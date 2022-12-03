<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Date"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="facturefournisseur.FactureFournisseurLc" %>
<%@ page import="ded.*"%>
<%@ page import="pub.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String id = null;
        String lien = null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree = null;
        String numFact = null;
        String typa = null;
        String nomClient = null;
        String nature = null;
        String typeOp = null;
        FactureFournisseur ff = null;
        String lc = "";
        String listefacture = null;
        String[] g;
        String[] k;
        String[] l;
        PubFactPaye p = null;
        String [] idop;
        String [] date_decaler;
        String [] remarque;
        String bute;
    %>
    <%out.println("apres facture");
        acte = request.getParameter("acte");
        bute = request.getParameter("bute");
        out.println("acte = " + acte);
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            nature = request.getParameter("nature");
            typeOp = request.getParameter("typeOp");
            if (typeOp == null) {
                typeOp = "facture";
            }
            lc = request.getParameter("lc");
            idop=request.getParameterValues("idop");
           date_decaler=request.getParameterValues("date_decaler");
           remarque=request.getParameterValues("remarque");
          if (acte.compareTo("decaler")==0)
          {
              u.decalerOP(idop, date_decaler);
               %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
    <%
          }
            if (acte.compareToIgnoreCase("attacheropprev") == 0) {
                String idop = (String) session.getValue("opaattacher");
                String[] listor = {idop};
                String[] idprev = request.getParameterValues("id");
                session.removeAttribute("opaattacher");
                String res = "";
                for (int i = 0; i < idprev.length; i++) {
                    res = u.attcherOpRCPrev(idprev[i], listor);
                }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=idop%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("insertavecprev") == 0) {
            ff = u.createOpSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("remarque"));
            String[] listor = {ff.getRemarque()};
            String res = u.attcherOpRCPrev(request.getParameter("idprev"), listor);
            if (res.compareToIgnoreCase("yes") == 0) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>");</script>
    <%
    } else {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=res%>");</script>
    <%
            }
        }
        if (acte.compareTo("INSERT") == 0) {
            if (typeOp.compareToIgnoreCase(Constante.typeOpFacture) == 0) {
                //rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("remarque"));
                rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("remarque"), request.getParameter("typeprevu"), request.getParameter("dateDePaiement"), request.getParameter("remarquePaiement"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=rep%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=request.getParameter("montantTTC")%>&avecOp=<%=rep%>");</script>
    <%
        }
        if (typeOp.compareToIgnoreCase(Constante.typeOpNormale) == 0) {
            //ff = u.createOpSimple(request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("tva"),request.getParameter("fournisseur"),request.getParameter("idDevise"),request.getParameter("remarque"));					
            ff = u.createOpSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("remarque"), request.getParameter("typeprevu"), request.getParameter("dateDePaiement"), request.getParameter("remarquePaiement"));

            if ((lc != null) && lc.startsWith("LC")) {
                String[] idLcArecup = {lc};
                String[] montantTab = {request.getParameter("montantTTC")};

                u.mapperOpFactureFournisseurLCTableau(ff.getRemarque(), idLcArecup, "facture op auto", montantTab);
            }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>");</script>
    <%
        }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=rep%>");</script>
    <%
        }

            if (acte.compareToIgnoreCase("dupliquer") == 0) {
                int n_dupl = Integer.parseInt(request.getParameter("nbPR"));
                String numObjet = request.getParameter("numObjet");
                String[] montantTab = new String[n_dupl];

                String[] lmois = new String[n_dupl];
                String[] lannee = new String[n_dupl];
                String[] ldate = new String[n_dupl];
                for (int i = 0; i < n_dupl; i++) {
                    lmois[i] = request.getParameter("mois" + i);
                    lannee[i] = request.getParameter("annee" + i);
                    ldate[i] = request.getParameter("date" + i);
                    montantTab[i] = request.getParameter("montant" + i);
                }

                u.dupliquerOP(numObjet, montantTab, n_dupl, lmois, lannee, ldate);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeOP.jsp");</script>
    <%}
            if (acte.compareToIgnoreCase("remplacer") == 0) {
                String numObjet=request.getParameter("numObjet");
                u.remplacerOP(numObjet);
                //rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"),request.getParameter("montantTTC"),request.getParameter("remarque"));
                rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("remarque"), request.getParameter("typeprevu"), request.getParameter("dateDePaiement"), request.getParameter("remarquePaiement"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=rep%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=request.getParameter("montantTTC")%>&avecOp=<%=rep%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("commissionGroupe") == 0) {

            String montant = (String) session.getAttribute("sommeCommission");
            String matricule = (String) session.getAttribute("matricule");
            String listComm = (String) session.getAttribute("listeCommission");

            session.removeAttribute("matricule");
            session.removeAttribute("sommeCommission");
            session.removeAttribute("listeCommission");

            String idordre = request.getParameter("idop");
            String remarque = request.getParameter("remarque");
            u.attacherOpCommission(idordre, listComm);

            // redirection vers base paie
%>
    <script language="JavaScript"> document.location.replace("http://192.168.0.42:8080/paie/payement/redirectToPayement.jsp?matricule=<%=matricule%>&montant=<%=montant%>&remarque=<%=remarque%>");</script>

    <%

        }
        if (acte.compareTo("INSERTSAL") == 0) {
            String idsolde = request.getParameter("idsolde");
            String[] lsolde = Utilitaire.split(idsolde, "-");
            String employe = request.getParameter("employe");
               //fonction comptabilite
            if (typeOp.compareToIgnoreCase(Constante.typeOpNormale) == 0) {
                ff = u.createOpSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("remarque"));
                if ((lc != null) && lc.startsWith("LC")) {
                    String[] idLcArecup = {lc};
                    String[] montantTab = {request.getParameter("montantTTC")};

                    u.mapperOpFactureFournisseurLCTableau(ff.getRemarque(), idLcArecup, "facture op auto", montantTab);
                }
                //System.out.print(lsolde.length);
                for (int i = 1; i < lsolde.length; i++) {
                    //System.out.print(ff.getNumFact()+" et "+lsolde[i]);
                    u.saveOpSolde(ff.getNumFact(), lsolde[i]);
                }

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>");</script>
    <%
        }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=rep%>");</script>
    <%
        }
        if (acte.compareTo("INSERTCOM") == 0) {
            if (typeOp.compareToIgnoreCase(Constante.typeOpFacture) == 0) {
                FactureFournisseur crt = new FactureFournisseur("facturefournisseurviseAop");//
                crt.setIdFactureFournisseur(request.getParameter("idDed"));
                FactureFournisseur[] reponse = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, "");
                if (reponse.length == 0) {
                    throw new Exception("Le facture n existe pas");
                }
                rep = u.createOp(request.getParameter("idDed"), request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("remarque"));
            }
            if (typeOp.compareToIgnoreCase(Constante.typeOpNormale) == 0) {
                ff = u.createOpSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("remarque"));
                if ((lc != null) && lc.startsWith("LC")) {
                    String[] idLcArecup = {lc};
                    String[] montantTab = {request.getParameter("montantTTC")};
                    u.mapperOpFactureFournisseurLCTableau(ff.getRemarque(), idLcArecup, "facture op auto", montantTab);
                }
                listefacture = request.getParameter("listefacture");
                int nbrechoix = Utilitaire.stringToInt(request.getParameter("nbrechoix"));
                g = Utilitaire.split(listefacture, ",");
                PubFactPaye p = new PubFactPaye();
                if (request.getParameter("pourcentage").compareTo("10") == 0) {
                    p.setNomTable("pubfacttousf");
                    for (int i = 0; i < nbrechoix; i++) {
                        PubFactPaye[] pf = (PubFactPaye[]) CGenUtil.rechercher(p, null, null, " and factclient='" + g[i] + "'");
                        u.createPayementCommissionMultiple(pf[0].getFactclient(), pf[0].getClient(), pf[0].getNumcompte(), request.getParameter("pourcentage"));
                    }
                    for (int j = 0; j < nbrechoix; j++) {
                        PubFactPaye[] pfp = (PubFactPaye[]) CGenUtil.rechercher(p, null, null, " and factclient='" + g[j] + "'");
                        String maxidop = u.getMaxId("ordonnerpayement");
                        u.insertCommissionOp(pfp[0].getFactclient(), maxidop, request.getParameter("pourcentage"));
                    }
                } else {
                    p.setNomTable("PUBFACTTOUSDIRECTION");
                    for (int i = 0; i < nbrechoix; i++) {
                        PubFactPaye[] pf = (PubFactPaye[]) CGenUtil.rechercher(p, null, null, " and factclient='" + g[i] + "'");
                        u.createPayementCommissionMultiple(pf[0].getFactclient(), pf[0].getClient(), pf[0].getNumcompte(), request.getParameter("pourcentage"));
                    }
                    for (int j = 0; j < nbrechoix; j++) {
                        PubFactPaye[] pfp = (PubFactPaye[]) CGenUtil.rechercher(p, null, null, " and factclient='" + g[j] + "'");
                        String maxidop = u.getMaxId("ordonnerpayement");
                        u.insertCommissionOp(pfp[0].getFactclient(), maxidop, request.getParameter("pourcentage"));
                    }
                }

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOpFfLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>");
    </script>
    <%
        }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=rep%>");</script>
    <%
                                    }
            if(acte.compareTo("ANNULATIONOPRESTE") == 0){
               String[] idop = request.getParameterValues("checkIdOP");
               if(idop.length == 0){
                    throw new Exception("Veuillez choisir au moins un element");
                }
                HashMap<String,String> remarque = new HashMap<String,String>();
               for(int i = 0; i < idop.length; i++){
                    String rmq = (request.getParameter("remarque_"+idop[i]) != null && !request.getParameter("remarque_"+idop[i]).isEmpty()) ?request.getParameter("remarque_"+idop[i]) : "Aucune" ;
                    remarque.put(idop[i],rmq );
               }
               u.annulerOPReste(idop, remarque);%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerpayementreste-annuler.jsp");</script>
                
       <% }
    
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=rep%>");</script>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
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




