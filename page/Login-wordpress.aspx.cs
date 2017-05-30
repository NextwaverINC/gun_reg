using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class page_Login_wordpress : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = Request.Params["user"];
        string pass = Request.Params["pass"];
        UserProfile up = new UserProfile();
        up._UserName = user;
        UserProfile.setProfile(up);
        Response.Redirect("../page/management.aspx");
    }
}