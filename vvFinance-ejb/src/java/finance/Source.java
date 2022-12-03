package finance;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Source extends bean.ClassMAPTable {

  public String source;
  public String desce;
  public Source(String sour,String desc) {
    super.setNomTable("Source");
    source=sour;
    this.desce=desc;
  }
  public String getTuppleID()
{
  return String.valueOf(source);
}
public String getAttributIDName()
{
  return "source";
  }
  public String getSource() {
    return source;
  }
  public void setSource(String source) {
    this.source = source;
  }
  public void setDesc(String desc) {
    this.desce = desc;
  }
  public String getDesc() {
    return desce;
  }
}