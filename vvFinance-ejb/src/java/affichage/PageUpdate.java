package affichage;

import java.sql.Connection;
import java.lang.reflect.Field;
import bean.CGenUtil;
import bean.ClassMAPTable;
import javax.servlet.http.HttpServletRequest;

public class PageUpdate extends PageInsert {

  private bean.ClassMAPTable critere;
  public PageUpdate(ClassMAPTable o,HttpServletRequest req,user.UserEJB u) throws Exception{
    setCritere(o);
    setReq(req);
    setUtilisateur(u);
    makeCritere();
    getData();
    makeFormulaire();
  }
  public void getData() throws Exception
  {
    ClassMAPTable[] result=(ClassMAPTable[])getUtilisateur().getData(getCritere(),null,null,null,"");
    if(result==null||result.length==0) throw new Exception("Pas de resultat pour votre consultation");
    setBase(result[0]);
  }
  public void makeHtml()
  {
  }
  public void makeCritere() throws Exception
  {
    String valeur=getReq().getParameter(getCritere().getAttributIDName());
    Field f=CGenUtil.getField(getCritere(),getCritere().getAttributIDName());
    CGenUtil.setValChamp(getCritere(),f,valeur);
  }
  public void makeFormulaire() throws Exception
  {
      formu=new Formulaire();
      affichage.Champ[] t=null;
      bean.Champ[] f=bean.ListeColonneTable.getFromListe(getBase(),null);
      t=new Champ[f.length];
      for(int i=0;i<t.length;i++)
      {
          t[i]=new Champ(f[i].getNomColonne());
          t[i].setLibelle(f[i].getNomColonne());
          t[i].setValeur(String.valueOf(CGenUtil.getValeurFieldByMethod(getBase(),f[i].getNomColonne())));
      }
      formu.setListeChamp(t);
  }
  public bean.ClassMAPTable getCritere() {
    return critere;
  }
  public void setCritere(bean.ClassMAPTable critere) {
    this.critere = critere;
  }

}