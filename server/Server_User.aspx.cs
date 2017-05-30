using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class server_Server_User : System.Web.UI.Page
{
    string Connection = "NextwaverDatabase";
    string OfficeSpaceId = "OF.0001";
    string DatabaseName = "desktop";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string Command = Request.Params["Command"];
        switch (Command)
        {
            case "LoadMenu": fnLoadMenu(); break;
            case "LoadPosition": fnLoadPosition(); break;
            case "SavePosition": fnSavePosition(); break;
            case "SaveUser": fnSaveUser(); break;
            case "LoadDataUser": fnLoadDataUser(); break;
            case "DeleteUser": fnDeleteUser(); break;
        }
    }

    private void fnDeleteUser()
    {
        string ID_LIST = Request.Params["ID_LIST"];
        string[] SP = ID_LIST.Split(new char[] { ',' });
        int CountOK = 0;
        try
        {
            WorkSpace.Service WS = new WorkSpace.Service();
            for (int i = 0; i < SP.Length; i++)
            {
                NextwaverDB.NColumns NCS = new NextwaverDB.NColumns();
                NCS.Add(new NextwaverDB.NColumn("STATUS", "D"));
                NCS.Add(new NextwaverDB.NColumn("UPDATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
                NCS.Add(new NextwaverDB.NColumn("UPDATE_BY", "system"));

                NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
                NWS.Add("ID", SP[i]);

                string[] OP = WS.UpdateData(Connection, OfficeSpaceId, DatabaseName, "users", NCS.ExportString(), NWS.ExportString(), "", "");
                CountOK++;
            }

            Response.Write("{\"output\":\"OK\"}");
        }
        catch { Response.Write("{\"output\":\"ERROR\",\"MSG\":\"ลบข้อมูลสำเร็จทั้งหมด "+CountOK+" จาก "+SP.Length+" รายการ\"}"); }

       
        //Response.Write("{\"output\":\"OK\"}");
    }

    private void fnLoadDataUser()
    {
        string ID = Request.Params["ID"];
        WorkSpace.Service WS = new WorkSpace.Service();
        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
        NWS.whereType = true;
        NWS.Where += "[@ID@ = '" + ID + "']";
      
        string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
        try
        {
            DataTable dt = WS.SelectAllColumnByWhere(Connection, OfficeSpaceId, DatabaseName, "users", NWS.ExportString(), "system");

            string USERNAME = "" + dt.Rows[0]["USERNAME"];
            string PASSWORD = "" + dt.Rows[0]["PASSWORD"];
            string TITLE = "" + dt.Rows[0]["TITLE"];
            string FIRSTNAME = "" + dt.Rows[0]["FIRSTNAME"];
            string LASTNAME = "" + dt.Rows[0]["LASTNAME"];
            string POSITION_CODE = "" + dt.Rows[0]["POSITION_CODE"];

            string OUTPUT = "{\"output\":\"OK\"";
            OUTPUT += ",\"USERNAME\":\"" + USERNAME + "\"";
            OUTPUT += ",\"PASSWORD\":\"" + PASSWORD + "\"";
            OUTPUT += ",\"TITLE\":\"" + TITLE + "\"";
            OUTPUT += ",\"FIRSTNAME\":\"" + FIRSTNAME + "\"";
            OUTPUT += ",\"LASTNAME\":\"" + LASTNAME + "\"";
            OUTPUT += ",\"POSITION_CODE\":\"" + POSITION_CODE + "\"";
            OUTPUT += "}";
            Response.Write(OUTPUT);
        }
        catch (Exception ex)
        {
            Response.Write("{\"output\":\"ERROR\",\"MSG\":\"ไม่สามารถโหลดข้อมูลได้\"}");
        }
    }

    private void fnSaveUser()
    {
        string ID = Request.Params["ID"];
        string username = Request.Params["username"];
        string password = Request.Params["password"];
        string usertype = Request.Params["usertype"];
        string title = Request.Params["title"];
        string firstname = Request.Params["firstname"];
        string lastname = Request.Params["lastname"];

        string Command = "New";
        if (ID != "") Command = "Edit";

        WorkSpace.Service WS = new WorkSpace.Service();
        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
        NWS.whereType = true;
        NWS.Where = "[@USERNAME@ = '" + username + "']";
        if (Command != "New")
        {
            NWS.Where += "[@ID@ != '" + ID + "']";
        }

        NextwaverDB.NColumns NCS_S = new NextwaverDB.NColumns();
        NCS_S.Add(new NextwaverDB.NColumn("USERNAME"));

        string NCS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NCS_S.ExportString(), true);
        string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);

        DataTable dt = WS.SelectByColumnAndWhere(Connection, OfficeSpaceId, DatabaseName, "users", NCS_Encrypt, NWS_Encrypt, "system");
        if (dt.Rows.Count > 0)
        {
            Response.Write("{\"output\":\"ERROR\",\"MSG\":\"ชื่อผู้ใช้งานนี้มีอยู่แล้วในระบบโปรดระบุใหม่\"}");
            return;
        }

        if (Command == "New")
        {
            NextwaverDB.NColumns NCS = new NextwaverDB.NColumns();
            NCS.Add(new NextwaverDB.NColumn("USERNAME", username));
            NCS.Add(new NextwaverDB.NColumn("PASSWORD", password));
            NCS.Add(new NextwaverDB.NColumn("TITLE", title));
            NCS.Add(new NextwaverDB.NColumn("FIRSTNAME", firstname));
            NCS.Add(new NextwaverDB.NColumn("LASTNAME", lastname));
            NCS.Add(new NextwaverDB.NColumn("POSITION_CODE", usertype));
            NCS.Add(new NextwaverDB.NColumn("CREATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("CREATE_BY", "system"));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_BY", "system"));
           
            string[] OP = WS.InsertData(Connection, OfficeSpaceId, DatabaseName, "users", NCS.ExportString(), "", "");

            if (OP[0].ToUpper() == "OK")
            {
                Response.Write("{\"output\":\"OK\"}");
                return;
            }
            else
            {
                Response.Write("{\"output\":\"ERROR\",\"MSG\":\"" + OP[1] + "\"}");
                return;
            }
        }
        else
        {
            NextwaverDB.NColumns NCS = new NextwaverDB.NColumns();
            NCS.Add(new NextwaverDB.NColumn("PASSWORD", password));
            NCS.Add(new NextwaverDB.NColumn("TITLE", title));
            NCS.Add(new NextwaverDB.NColumn("FIRSTNAME", firstname));
            NCS.Add(new NextwaverDB.NColumn("LASTNAME", lastname));
            NCS.Add(new NextwaverDB.NColumn("POSITION_CODE", usertype));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_BY", "system"));

            NWS = new NextwaverDB.NWheres();
            NWS.Add("ID", ID);

            string[] OP = WS.UpdateData(Connection, OfficeSpaceId, DatabaseName, "users", NCS.ExportString(), NWS.ExportString(), "", "");

            if (OP[0].ToUpper() == "OK")
            {
                Response.Write("{\"output\":\"OK\"}");
                return;
            }
            else
            {
                Response.Write("{\"output\":\"ERROR\",\"MSG\":\"" + OP[1] + "\"}");
                return;
            }
        }
    }  

    private void fnSavePosition()
    {
        string Code = Request.Params["Code"];
        string POSITION_NAME = Request.Params["Name"];
        string ID_List = Request.Params["ID_List"];
        string PARENT_CODE = Request.Params["parent"];
               
        if (Code == "")
        {
            NextwaverDB.NColumns NCS = new NextwaverDB.NColumns();
            NCS.Add(new NextwaverDB.NColumn("POSITION_CODE", PARENT_CODE + getNewPOSITION_CODE(PARENT_CODE)));
            NCS.Add(new NextwaverDB.NColumn("POSITION_NAME", POSITION_NAME));
            NCS.Add(new NextwaverDB.NColumn("PARENT_CODE", PARENT_CODE));
            NCS.Add(new NextwaverDB.NColumn("CREATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("CREATE_BY", ""));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_BY", ""));
            NCS.Add(new NextwaverDB.NColumn("MENU", ID_List));

            WorkSpace.Service WS = new WorkSpace.Service();
            string[] OP = WS.InsertData(Connection, OfficeSpaceId, DatabaseName, "position", NCS.ExportString(), "", "");

            if (OP[0].ToUpper() == "OK")
            {
                Response.Write("{\"output\":\"OK\"}");
                return;
            }
            else
            {
                Response.Write("{\"output\":\"ERROR\",\"MSG\":\"" + OP[1] + "\"}");
                return;
            }
        }
        else
        {
            NextwaverDB.NColumns NCS = new NextwaverDB.NColumns();
            NCS.Add(new NextwaverDB.NColumn("POSITION_NAME", POSITION_NAME));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_DATE", DateTime.Now.ToString("dd/MM/yyyy")));
            NCS.Add(new NextwaverDB.NColumn("UPDATE_BY", ""));
            NCS.Add(new NextwaverDB.NColumn("MENU", ID_List));
            NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
            NWS.Add("ID", Code);

            WorkSpace.Service WS = new WorkSpace.Service();
            string[] OP = WS.UpdateData(Connection, OfficeSpaceId, DatabaseName, "position", NCS.ExportString(), NWS.ExportString(), "", "");

            if (OP[0].ToUpper() == "OK")
            {
                Response.Write("{\"output\":\"OK\"}");
                return;
            }
            else
            {
                Response.Write("{\"output\":\"ERROR\",\"MSG\":\"" + OP[1] + "\"}");
                return;
            }

        }
    }
    string getNewPOSITION_CODE(string PARENT_CODE)
    {
        NextwaverDB.NXPath NXP = new NextwaverDB.NXPath();
        NextwaverDB.NWheres NWS = new NextwaverDB.NWheres();
        NWS.whereType = true;
        NWS.Where = "[" + NXP.getMaxValue("@POSITION_CODE@") + "]";
        NWS.Where += "[@PARENT_CODE@ = '" + PARENT_CODE + "']";

        NextwaverDB.NColumns NCS_S = new NextwaverDB.NColumns();
        NCS_S.Add(new NextwaverDB.NColumn("POSITION_CODE"));

        string NCS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NCS_S.ExportString(), true);
        string NWS_Encrypt = new EncryptDecrypt.CryptorEngine().Encrypt(NWS.ExportString(), true);
        
        WorkSpace.Service WS = new WorkSpace.Service();

       
        DataTable dt = WS.SelectByColumnAndWhere(Connection, OfficeSpaceId, DatabaseName, "position", NCS_Encrypt, NWS_Encrypt,"system");
        int MaxID = 0;
        try
        {
            string PC = dt.Rows[0][0].ToString();
            if (PARENT_CODE != "")
                PC = PC.Replace(PARENT_CODE, "");
            MaxID = int.Parse(PC);

        }
        catch { }

        string NewID = "" + (MaxID + 1);
        for (int i = NewID.Length; i < 3; i++)
        {
            NewID = "0" + NewID;
        }
        return NewID;
    }
    private void fnLoadPosition()
    {
        WorkSpace.Service WS = new WorkSpace.Service();
        
        DataTable dt = WS.SelectAll(Connection, OfficeSpaceId, DatabaseName, "position", "");
        string strSort = "POSITION_CODE ASC";

        DataView dtview = new DataView(dt);
        dtview.Sort = strSort;
        DataTable dtsorted = dtview.ToTable();
       
        string POSITION_NAME, POSITION_CODE, PARENT_CODE;
        string SData = "";
        for (int i = 0; i < dtsorted.Rows.Count; i++)
        {
            POSITION_NAME = dtsorted.Rows[i]["POSITION_NAME"].ToString();
            POSITION_CODE = dtsorted.Rows[i]["POSITION_CODE"].ToString();
            PARENT_CODE = dtsorted.Rows[i]["PARENT_CODE"].ToString();

            if (SData == "")
                SData = "{";
            else
                SData += ",{";

            SData += "\"NAME\":\"" + POSITION_NAME + "\"";
            SData += ",\"CODE\":\"" + POSITION_CODE + "\"";



            SData += "}";
        }

        Response.Write("{\"records\":[" + SData + "]}");
        
    }
    private void fnLoadMenu()
    {
        XmlDocument xDoc = new XmlDocument();
        xDoc.Load(Server.MapPath("config/desktop.xml"));
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
                    if (SubMenu == "")
                        SubMenu = "{";
                    else
                        SubMenu += ",{";

                    SubMenu += "\"ID\":\"" + ID + "." + j + "\"";
                    SubMenu += ",\"NAME\":\"" + SubName + "\"";
                    SubMenu += ",\"PATH\":\"" + SubUrl + "\"";

                    SubMenu += ",\"CLASS\":\"\"";
                    SubMenu += ",\"ISSUB\":\"0\"";


                    SubMenu += "}";
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

                    SubMenu += "\"ID\":\"" + ID + "." + z + "\"";
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

                        XmlNode nodeMapping = xManage.SelectSingleNode("//Config/Mappings/Mapping[@ID='" + MappingID + "']");
                        // <Mapping ID="1" Name="Users" RowID="E" ManagementID="Management1" ToolID="Tools1" ThemeID="Theme1" ParameterID="Parameter1" />
                        string MID = nodeMapping.Attributes["ManagementID"].Value;
                        string TID = nodeMapping.Attributes["ToolID"].Value;

                        if (SubMenuItem == "")
                            SubMenuItem = "{";
                        else
                            SubMenuItem += ",{";

                        SubMenuItem += "\"ID\":\"" + ID + "." + z + "." + y + "\"";
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


        Response.Write("{\"records\":[" + SMenu + "]}");
    }
}