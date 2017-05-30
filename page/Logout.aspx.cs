using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class page_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserProfile.setProfile(null);
        Response.Redirect("../page/login.html");
    }
}