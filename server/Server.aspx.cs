using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class page_Server : System.Web.UI.Page
{    
    string OfficeSpaceId = "OF.0001";
    bool strToBool(string str)
    {
        if (str == "T") return true;
        else return false;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string Command = Request.Params["Command"];
        switch (Command)
        {
            case "LoadMenu": fnLoadMenu(); break;
            case "LoadManagement": fnLoadManagement(); break;
            case "SearchManagement": fnSearchManagement();break;
            case "Login": fnLogin(); break;
        }
    }

    private void fnLogin()
    {
        string user_name = "" + Request.Params["user_name"];
        string password = "" + Request.Params["password"];

        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
        NWS.Add(new NextwaverDB.NWhere("USERNAME", user_name));
        NWS.Add(new NextwaverDB.NWhere("PASSWORD", password));

        NextwaverDB.NColumns NCS_S = new NextwaverDB.NColumns();
        NCS_S.Add(new NextwaverDB.NColumn("USERNAME"));
        NCS_S.Add(new NextwaverDB.NColumn("POSITION_CODE"));
        NCS_S.Add(new NextwaverDB.NColumn("ID"));

        WorkSpace.Service WS = new WorkSpace.Service();

        string NCS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NCS_S.ExportString(), true);
        string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);

        DataTable dt = WS.SelectByColumnAndWhere("NextwaverDatabase", OfficeSpaceId, "desktop", "users", NCS_Encrypt, NWS_Encrypt, "system");
        if (dt.Rows.Count == 0)
        {
            Response.Write("ERROR$UserName หรือ Password ไม่ถูกต้อง");
            return;
        }

        UserProfile up = new UserProfile();
        up._UserName = user_name;
        up._POSITION_CODE = "" + dt.Rows[0]["POSITION_CODE"];
        UserProfile.setProfile(up);

        Response.Write("OK$UserName หรือ Password ไม่ถูกต้อง");
        return;
    }
    
    private void fnSearchManagement()
    {
        string MID = "" + Request.Params["MID"];
        string TID = "" + Request.Params["TID"];

        if (MID == "") MID = "Management1";
        if (TID == "") TID = "Tools1";

        Random RD = new Random();
        int SRD = RD.Next(9999, 100000);

        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
        NWS.whereType = true;
        NWS.Where = "";
        string SC01 = "" + Request.Params["SC01"];
        string ST01 = "" + Request.Params["ST01"];
        string SC02 = "" + Request.Params["SC02"];
        string ST02 = "" + Request.Params["ST02"];
        string SC03 = "" + Request.Params["SC03"];
        string ST03 = "" + Request.Params["ST03"];
        string SC04 = "" + Request.Params["SC04"];
        string ST04 = "" + Request.Params["ST04"];
        string GRP_ID = "" + Request.Params["GRP_ID"];
        if (ST01 != "") NWS.Where += "[@" + SC01 + "@ = '" + ST01 + "']";
        if (ST02 != "") NWS.Where += "[@" + SC02 + "@ = '" + ST02 + "']";
        if (ST03 != "") NWS.Where += "[@" + SC03 + "@ = '" + ST03 + "']";
        if (ST04 != "") NWS.Where += "[@" + SC04 + "@ = '" + ST04 + "']";

        Session[MID + SRD.ToString()] = NWS;
        Session[MID + "SC01" + SRD.ToString()] = SC01;
        Session[MID + "ST01" + SRD.ToString()] = ST01;
        Session[MID + "SC02" + SRD.ToString()] = SC02;
        Session[MID + "ST02" + SRD.ToString()] = ST02;
        Session[MID + "SC03" + SRD.ToString()] = SC03;
        Session[MID + "ST03" + SRD.ToString()] = ST03;
        Session[MID + "SC04" + SRD.ToString()] = SC04;
        Session[MID + "ST04" + SRD.ToString()] = ST04;
        Session[MID + "GRP_ID" + SRD.ToString()] = GRP_ID;
        string SOutput = "{\"SRD\":\"" + SRD + "\"}";
        Response.Write(SOutput);
    }
    private void fnLoadManagement()
    {
        string MID = "" + Request.Params["MID"];
        string TID = "" + Request.Params["TID"];
        if (MID == "null") MID = "";
        if (TID == "null") TID = "";
        if (MID == "") MID = "Bookgun";
        if (TID == "") TID = "GunTools";

        string SRD = "" + Request.Params["SRD"];
        if (SRD == "null") SRD = "";

        string ConfigName = Request.Params["ConfigName"];
        if (ConfigName == "null" || ConfigName == "" || ConfigName == null) ConfigName = "Gunbook";

        XmlDocument xDoc = new XmlDocument();
        xDoc.Load(Server.MapPath("config/" + ConfigName + ".xml"));

        XmlNode nodeManagement = xDoc.SelectSingleNode("//Config/Managements/Management[@ID='" + MID + "']");

        string ManagementTitle = nodeManagement.SelectSingleNode("./Headers").Attributes["Title"].Value;

        XmlNodeList listColumn = nodeManagement.SelectNodes("./Table/Column");
        string SColumn = "";        
        for (int j = 0; j < listColumn.Count; j++)
        {
            // <Column Name="ID" Text="ลำดับ" Width="70" Format="xxx" Visible="T" DataAlign="D" ColumnAlign="D" FixedColumn="F" />
            string CN = listColumn[j].Attributes["Name"].Value.ToUpper();
            string TXT = listColumn[j].Attributes["Text"].Value;
            bool Visible = strToBool(listColumn[j].Attributes["Visible"].Value);
            bool Fiexed = strToBool(listColumn[j].Attributes["FixedColumn"].Value);
            string Width = listColumn[j].Attributes["Width"].Value;

            if (Visible)
            {
                if (SColumn == "")
                    SColumn = "{";
                else
                    SColumn += ",{";

                SColumn += "\"NAME\":\"" + CN + "\"";
                SColumn += ",\"TEXT\":\"" + TXT + "\"";
                SColumn += ",\"WIDTH\":\"" + Width + "\"";
                
                if (j > 1)
                    SColumn += ",\"CLASS\":\"hidden-480\"";
                else
                    SColumn += ",\"CLASS\":\"center\"";


                SColumn += "}";
            }
        }


        DataTable dtTemp;
        string Type = nodeManagement.Attributes["Type"].Value;
        string SGroup = "";
        string SPageDisplay = "10";
        string SGroupTxt = "";
        string sGroupColumn = "";
        string sGroupValue = "";
        if (Type.ToUpper() == "OFFICE")
        {
            XmlNode nodeNextwaverDB = nodeManagement.SelectSingleNode("./NextwaverDB");
            string Connection = nodeNextwaverDB.Attributes["Connection"].Value;
            string DatabaseName = nodeNextwaverDB.Attributes["DatabaseName"].Value;
            string TableName = nodeNextwaverDB.Attributes["TableName"].Value;

            WorkSpace.Service WS = new WorkSpace.Service();

            //<Group Connection="NextwaverDatabase" DatabaseName="GunBook" TableName="Book" Display="BOOKNO" Value="BOOKNO" Text="เลขหนังสือ"/>
            XmlNode nodeGroup = nodeManagement.SelectSingleNode("./Group");
            if (nodeGroup != null)
            {
                string sDisplay = nodeGroup.Attributes["Display"].Value;
                string sValue = nodeGroup.Attributes["Value"].Value;
                sGroupColumn = sValue;
                SGroupTxt = nodeGroup.Attributes["Text"].Value;
                NextwaverDB.NColumns NCS_S = new NextwaverDB.NColumns();
                NCS_S.Add(new NextwaverDB.NColumn(sDisplay));
                if (sDisplay != sValue)
                    NCS_S.Add(new NextwaverDB.NColumn(sValue));
                //  DataTable dt = WS.SelectByColumnAndWhere(Connection, OfficeSpaceId, DatabaseName, "Book", NCS_Encrypt, NWS_Encrypt, up._UserName);
                dtTemp = WS.SelectAllByColumn(Connection, OfficeSpaceId, nodeGroup.Attributes["DatabaseName"].Value, nodeGroup.Attributes["TableName"].Value
                    , NCS_S.ExportString(), "");
                if (SRD != "")
                    sGroupValue = "" + Session[MID + "GRP_ID" + SRD.ToString()];

                for (int i = 0; i < dtTemp.Rows.Count; i++)
                {
                    if (SGroup == "")
                        SGroup = "{";
                    else
                        SGroup += ",{";

                    if (sGroupValue == "") sGroupValue = "" + dtTemp.Rows[i][sValue];

                     SGroup += "\"VALUE\":\"" + dtTemp.Rows[i][sValue] + "\"";
                    SGroup += ",\"TITLE\":\"" + dtTemp.Rows[i][sDisplay] + "\"";
                    SGroup += ",\"VAL\":\"" + sGroupValue + "\"";
                    SGroup += "}";
                } 
            }
            XmlNode nodePageDisplay = nodeManagement.SelectSingleNode("./PageDisplay");
            if (nodePageDisplay != null)
                SPageDisplay = nodePageDisplay.InnerText;
            XmlNodeList listWhere = nodeManagement.SelectNodes("./Wheres/Where");
            if (listWhere.Count == 0)
            {
                // string sGroupColumn = "";
                //string sGroupValue = "";
                if (SRD == "")
                {
                    if (sGroupColumn == "")
                        dtTemp = WS.SelectAll(Connection, OfficeSpaceId, DatabaseName, TableName, "System");
                    else
                    {
                        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
                        NWS.whereType = true;
                        NWS.Where = "";
                        NWS.Where += "[@" + sGroupColumn + "@ = '" + sGroupValue + "']";
                        string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
                        dtTemp = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, TableName, NWS.ExportString(), "system");
                    }
                }                   
                else
                {
                    NextwaverDB.NWheres NWS = (NextwaverDB.NWheres)Session[MID + SRD];
                    if(NWS == null)
                    {
                        if (sGroupColumn == "")
                            dtTemp = WS.SelectAll(Connection, OfficeSpaceId, DatabaseName, TableName, "System");
                        else
                        {
                            NWS = new NextwaverDB.NWheres();
                            NWS.whereType = true;
                            NWS.Where = "";
                            NWS.Where += "[@" + sGroupColumn + "@ = '" + sGroupValue + "']";
                            string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
                            dtTemp = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, TableName, NWS.ExportString(), "system");
                        }
                    }                       
                    else
                    {
                        if (sGroupColumn == "")
                        {
                            string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
                            dtTemp = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, TableName, NWS.ExportString(), "system");
                        }
                        else
                        {
                            NWS.Where += "[@" + sGroupColumn + "@ = '" + sGroupValue + "']";
                            string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
                            dtTemp = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, TableName, NWS.ExportString(), "system");
                        }                       
                    }
                }                
            }
            else
            {
                NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
                NWS.whereType = true;
                NWS.Where = "";
                if (SRD != "")
                    NWS = (NextwaverDB.NWheres)Session[MID + SRD];

                for (int i = 0; i < listWhere.Count; i++)
                {
                    string tmpColumn = listWhere[i].Attributes["Column"].Value;
                    string tmpOperation = listWhere[i].Attributes["Operation"].Value;
                    string tmpValue = listWhere[i].Attributes["Value"].Value;
                    NWS.Where += "[@" + tmpColumn + "@ " + tmpOperation + " '" + tmpValue + "']";                    
                }

                if (sGroupColumn != "")
                    NWS.Where += "[@" + sGroupColumn + "@ = '" + sGroupValue + "']";

                if (SRD != "" )
                {
                    NextwaverDB.NWheres NWS2 = (NextwaverDB.NWheres)Session[MID + SRD];
                    if (NWS2 != null)
                        NWS.Where += NWS2.Where;
                }

                string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
                dtTemp = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, TableName, NWS.ExportString(), "system");
            }


        }
        else
        {
            XmlNode nodeConnection = nodeManagement.SelectSingleNode("./Connection/Item");
            string ServerName = nodeConnection.Attributes["Server"].Value;
            string Database = nodeConnection.Attributes["Database"].Value;
            string Login = nodeConnection.Attributes["Login"].Value;
            string Password = nodeConnection.Attributes["Password"].Value;
            string strConnect = "Data Source=@Source; uid=@Uid; pwd=@Pass; Initial Catalog=@Database;";
            strConnect = strConnect.Replace("@Source", ServerName);
            strConnect = strConnect.Replace("@Uid", Login);
            strConnect = strConnect.Replace("@Pass", Password);
            strConnect = strConnect.Replace("@Database", Database);

            string Query = nodeManagement.SelectSingleNode("./Query/SQL[@ID='Main']").InnerText;

            ConnectServer cConn = new ConnectServer();
            dtTemp = cConn.Retreive(Query, strConnect);
        }

        string SRow = "";
        if (dtTemp != null)
        {
            for (int i = 0; i < dtTemp.Rows.Count; i++)
            {
                if (SRow == "")
                    SRow = "{";
                else
                    SRow += ",{";

                SRow += "\"RowID\":\"" + i + "\"";

                string SSColumn = "";
                DataRow dr = dtTemp.Rows[i];
                for (int j = 0; j < listColumn.Count; j++)
                {
                    string CN = listColumn[j].Attributes["Name"].Value.ToUpper();
                    bool Visible = strToBool(listColumn[j].Attributes["Visible"].Value);
                    string CV = dr[CN].ToString();

                    string CLASSSTATUS = "";

                    if (CN.ToString() == "STATUS")
                    {
                        string[] SP = CV.Split(new char[] { ' ' });
                        switch (SP[0])
                        {
                            case "1": CLASSSTATUS = "label label-lg label-success arrowed-in arrowed-in-right"; break; // SUCESS
                            case "2": CLASSSTATUS = "label label-lg label-yellow arrowed-in arrowed-in-right"; break; // WARNING
                            case "3": CLASSSTATUS = "label label-lg label-danger arrowed-in arrowed-in-right"; break; // DANGER
                            case "4": CLASSSTATUS = "label label-lg label-info arrowed-in arrowed-in-right"; break; // INFO
                            case "5": CLASSSTATUS = "label label-lg label-inverse arrowed-in arrowed-in-right"; break; // BLACK
                            case "6": CLASSSTATUS = "label label-lg label-purple arrowed-in arrowed-in-right"; break; // PURPLE
                            case "7": CLASSSTATUS = "label label-lg label-pink arrowed-in arrowed-in-right"; break; // PINK
                            case "8": CLASSSTATUS = "label label-lg label-grey arrowed-in arrowed-in-right"; break; // grey
                        }
                    }

                    if (SSColumn == "")
                        SSColumn = "{";
                    else
                        SSColumn += ",{";

                    SSColumn += "\"NAME\":\"" + CN + "\"";
                    SSColumn += ",\"VALUE\":\"" + CV + "\"";

                    if (Visible)
                    {
                        if (j > 1)
                            SSColumn += ",\"CLASS\":\"hidden-480\"";
                        else
                            SSColumn += ",\"CLASS\":\"center\"";
                    }
                    else
                        SSColumn += ",\"CLASS\":\"hidden\"";

                    SSColumn += ",\"CLASSSTATUS\":\"" + CLASSSTATUS + "\"";
                    SSColumn += "}";
                }
                SRow += ",\"COLUMN\":[" + SSColumn + "]";
                SRow += "}";
            }
        }        

        XmlNodeList listTool = xDoc.SelectNodes("//Config/Tools/Tool[@ID='" + TID + "']/Item");

        string STools = "";
        for (int i = 0; i < listTool.Count; i++)
        {
            //<Item Name="Add" Type="SB" Visible="F" DisplayStyle="IAT" Text="เพิ่มผู้ใช้งาน" Tooltiptext="เพิ่มผู้ใช้งาน" Click="AddUser" Image="1" S_Enable="S:0:1:2:3:4:5:6:7:8:9" S_Visible="S:0:1:2:3:4:5:6:7:8:9"/>
            string Name = listTool[i].Attributes["Name"].Value;
            bool Visible = strToBool(listTool[i].Attributes["Visible"].Value);
            string Image = listTool[i].Attributes["Image"].Value;
            string Text = listTool[i].Attributes["Text"].Value;
            string Click = listTool[i].Attributes["Click"].Value;
            string Tooltiptext = listTool[i].Attributes["Tooltiptext"].Value;
            if (Visible)
            {
                if (STools == "")
                    STools = "{";
                else
                    STools += ",{";


                STools += "\"NAME\":\"" + Name + "\"";
                STools += ",\"IMAGE\":\"ace-icon fa " + Image + " align-top bigger-125\"";
                STools += ",\"TEXT\":\"" + Text + "\"";
                STools += ",\"CLICK\":\"" + Click + "\"";
                STools += ",\"TID\":\"" + TID + "\"";
                STools += ",\"COFNAME\":\"" + ConfigName + "\"";
                STools += ",\"TOOLTIP\":\"" + Tooltiptext + "\"";
                
                STools += "}";
            }
        }

        string SSearchColumn = "";
        XmlNodeList listSearch = nodeManagement.SelectNodes("./Searchs/Search");

        int ColumnIndex = 1;
        for (int i = 0; i < listSearch.Count; i++)
        {
            string FiledName = listSearch[i].Attributes["FiledName"].Value;
            string Title = listSearch[i].Attributes["Text"].Value;
            string SearchType = listSearch[i].Attributes["Type"].Value;

            if (FiledName != "")
            {
                string CINDEX = "1";
                for (int j = 0; j < listColumn.Count; j++)
                {
                    string CName = listColumn[j].Attributes["Name"].Value;
                    if (CName == FiledName)
                        CINDEX = "" + (j + 1);
                }


                if (SSearchColumn == "")
                    SSearchColumn = "{";
                else
                    SSearchColumn += ",{";

                SSearchColumn += "\"NAME\":\"" + FiledName + "\"";
                SSearchColumn += ",\"TITLE\":\"" + Title + "\"";

                if (SRD != "")
                {
                    NextwaverDB.NWheres NWS = (NextwaverDB.NWheres)Session[MID + SRD];
                    if (NWS != null)
                    {
                        SSearchColumn += ",\"VAL1\":\"" + Session[MID + "SC01" + SRD] + "\"";
                        SSearchColumn += ",\"VAL2\":\"" + Session[MID + "SC02" + SRD] + "\"";
                        SSearchColumn += ",\"VAL3\":\"" + Session[MID + "SC03" + SRD] + "\"";
                        SSearchColumn += ",\"VAL4\":\"" + Session[MID + "SC04" + SRD] + "\"";
                    }
                }

                SSearchColumn += "}";
                ColumnIndex++;
            }
        }

        string ST1 = "" + Session[MID + "ST01" + SRD];
        string ST2 = "" + Session[MID + "ST02" + SRD];
        string ST3 = "" + Session[MID + "ST03" + SRD];
        string ST4 = "" + Session[MID + "ST04" + SRD];

        string SOutput = "{\"records\":[" + SRow + "]" +
            ",\"columns\":[" + SColumn + "]" +
            ",\"tools\":[" + STools + "]" +
            ",\"title\":\"" + ManagementTitle + "\"" +
            ",\"search\":[" + SSearchColumn + "]" +
            ",\"ST1\":\"" + ST1 + "\",\"ST2\":\"" + ST2 + "\",\"ST3\":\"" + ST3 + "\",\"ST4\":\"" + ST4 + "\"" +
            ",\"group\":[" + SGroup + "]" +
            ",\"group_txt\":\"" + SGroupTxt + "\"" +
            ",\"group_val\":\"" + sGroupValue + "\"" +
            ",\"pagedisplay\":\"" + SPageDisplay + "\"" +
            "}";

        Response.Write(SOutput);
    }
    private void fnLoadMenu()
    {
        UserProfile up = UserProfile.getProfile();
        XmlDocument xDoc = new XmlDocument();
        xDoc.Load(Server.MapPath("config/desktop.xml"));
        string[] MENU_LIST = { };
        if (up._POSITION_CODE != "001")
        {
            NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
            NWS.Add(new NextwaverDB.NWhere("POSITION_CODE", up._POSITION_CODE));

            NextwaverDB.NColumns NCS_S = new NextwaverDB.NColumns();
            NCS_S.Add(new NextwaverDB.NColumn("MENU"));

            WorkSpace.Service WS = new WorkSpace.Service();

            string NCS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NCS_S.ExportString(), true);
            string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);

            DataTable dt = WS.SelectByColumnAndWhere("NextwaverDatabase", OfficeSpaceId, "desktop", "position", NCS_Encrypt, NWS_Encrypt, "system");
            MENU_LIST = ("" + dt.Rows[0][0]).Split(new char[] { ',' });
        }

        XmlNodeList listMenu = xDoc.SelectNodes("//config/menus");
        string SMenu = "";

        string Active = Request.Params["Active"];
        if (Active == "") Active = "1";
        for (int i = 0; i < listMenu.Count; i++)
        {
            //ID="1" Name="Demo" Icon="menu-icon fa fa-tachometer" Path=""
            string ID = listMenu[i].Attributes["ID"].Value;
            string Name = listMenu[i].Attributes["Name"].Value;
            string Icon = listMenu[i].Attributes["Icon"].Value;
            
            string MType = listMenu[i].Attributes["Type"].Value;

            bool isAccess = true;
            if (MENU_LIST.Length > 0)
            {
                isAccess = false;
                for (int z = 0; z < MENU_LIST.Length; z++)
                {
                    if (MENU_LIST[z] == ID)
                    {
                        isAccess = true;
                        break;
                    }
                }
            }

            if (isAccess)
            {
                if (SMenu == "")
                    SMenu = "{";
                else
                    SMenu += ",{";

                SMenu += "\"ID\":\"" + ID + "\"";
                SMenu += ",\"NAME\":\"" + Name + "\"";
                SMenu += ",\"ICON\":\"" + Icon + "\"";

                //SMenu += ",\"URL\":\"main.htm?ID=" + ID + "\"";           

                string SubMenu = "";
                if (MType.ToUpper() == "URL")
                {
                    string URL = "";
                    try
                    {
                        URL = listMenu[i].Attributes["Url"].Value;
                    }
                    catch { }
                    SMenu += ",\"PATH\":\"" + URL + "\"";
                    //{{x.PATH}}?ID={{ x.ID }}

                    XmlNodeList SubNode = listMenu[i].SelectNodes("./menu");
                    for (int j = 0; j < SubNode.Count; j++)
                    {
                        //Name="Demo2" Icon="menu-icon fa fa-desktop" Url="../page/management.aspx"
                        string SubName = SubNode[j].Attributes["Name"].Value;
                        string SubIcon = SubNode[j].Attributes["Icon"].Value;
                        string SubUrl = SubNode[j].Attributes["Url"].Value;
                        string SubID = SubNode[j].Attributes["ID"].Value;

                        isAccess = true;
                        if (MENU_LIST.Length > 0)
                        {
                            isAccess = false;
                            for (int z = 0; z < MENU_LIST.Length; z++)
                            {
                                if (MENU_LIST[z] == SubID)
                                {
                                    isAccess = true;
                                    break;
                                }
                            }
                        }

                        if (isAccess)
                        {
                            if (SubMenu == "")
                                SubMenu = "{";
                            else
                                SubMenu += ",{";

                            SubMenu += "\"ID\":\"" + SubID + "\"";
                            SubMenu += ",\"NAME\":\"" + SubName + "\"";
                            SubMenu += ",\"PATH\":\"" + SubUrl + "\"";

                            SubMenu += ",\"CLASS\":\"\"";
                            SubMenu += ",\"ISSUB\":\"0\"";


                            SubMenu += "}";
                        }                       
                    }
                }
                else
                {
                    string ManagementName = listMenu[i].Attributes["ManagementName"].Value;
                    SMenu += ",\"PATH\":\"management.aspx?ID=" + ID + "&ConfigName=" + ManagementName + "\"";

                    XmlDocument xManage = new XmlDocument();
                    xManage.Load(Server.MapPath("config/" + ManagementName + ".xml"));
                    XmlNodeList listView = xManage.SelectNodes("//Config/Views/View");
                    for (int z = 0; z < listView.Count; z++)
                    {
                        string SubName = listView[z].Attributes["Name"].Value;
                        string SubEnable = listView[z].Attributes["Enable"].Value;

                        if (SubMenu == "")
                            SubMenu = "{";
                        else
                            SubMenu += ",{";

                        SubMenu += "\"ID\":\"XXXX\"";
                        SubMenu += ",\"NAME\":\"" + SubName + "\"";
                        SubMenu += ",\"PATH\":\"\"";

                        XmlNodeList listItem = listView[z].SelectNodes("./Item");
                        string SubMenuItem = "";
                        for (int y = 0; y < listItem.Count; y++)
                        {
                            string IconID = listItem[y].Attributes["IconID"].Value;
                            string sName = listItem[y].Attributes["Name"].Value;
                            string MappingID = listItem[y].Attributes["MappingID"].Value;
                            string SubItemID = ID + "." + z + "." + y;

                            isAccess = true;
                            if (MENU_LIST.Length > 0)
                            {
                                isAccess = false;
                                for (int n = 0; n < MENU_LIST.Length; n++)
                                {
                                    if (MENU_LIST[n] == SubItemID)
                                    {
                                        isAccess = true;
                                        break;
                                    }
                                }
                            }

                            if (isAccess)
                            {
                                XmlNode nodeMapping = xManage.SelectSingleNode("//Config/Mappings/Mapping[@ID='" + MappingID + "']");
                                // <Mapping ID="1" Name="Users" RowID="E" ManagementID="Management1" ToolID="Tools1" ThemeID="Theme1" ParameterID="Parameter1" />
                                string MID = nodeMapping.Attributes["ManagementID"].Value;
                                string TID = nodeMapping.Attributes["ToolID"].Value;

                                if (SubMenuItem == "")
                                    SubMenuItem = "{";
                                else
                                    SubMenuItem += ",{";

                                SubMenuItem += "\"ID\":\"" + SubItemID + "\"";
                                SubMenuItem += ",\"NAME\":\"" + sName + "\"";
                                SubMenuItem += ",\"PATH\":\"management.aspx?ID=" + SubItemID + "&CFN=" + ManagementName + "&MID=" + MID + "&TID=" + TID + "\"";
                                if (SubItemID == Active)
                                {
                                    Active = ID;
                                    SubMenu += ",\"ACTIVE\":\"active open\"";
                                    SubMenuItem += ",\"ACTIVE\":\"active\"";
                                }
                                else
                                    SubMenuItem += ",\"ACTIVE\":\"\"";

                                SubMenuItem += "}";
                            }
                            

                        }
                        SubMenu += ",\"SUBMENU\":[" + SubMenuItem + "]";

                        if (SubMenuItem == "")
                        {
                            SubMenu += ",\"CLASS\":\"\"";
                            SubMenu += ",\"ISSUB\":\"0\"";
                        }
                        else
                        {
                            SubMenu += ",\"CLASS\":\"dropdown-toggle\"";
                            SubMenu += ",\"ISSUB\":\"1\"";
                        }

                        SubMenu += "}";

                    }

                }

                if (SubMenu == "")
                {
                    SMenu += ",\"CLASS\":\"\"";
                    SMenu += ",\"ISSUB\":\"0\"";
                }
                else
                {
                    SMenu += ",\"CLASS\":\"dropdown-toggle\"";
                    SMenu += ",\"ISSUB\":\"1\"";
                }
                if (ID == Active)
                    SMenu += ",\"ACTIVE\":\"active\"";
                else
                    SMenu += ",\"ACTIVE\":\"\"";

                SMenu += ",\"SUBMENU\":[" + SubMenu + "]";

                SMenu += "}";

            }            
        }     

        Response.Write("{\"records\":[" + SMenu + "]}");


    }
}