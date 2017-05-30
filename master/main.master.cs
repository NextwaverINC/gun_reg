using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class master_main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserProfile up = UserProfile.getProfile();
        if (up == null)
        {
            Response.Redirect("../page/login.html");
        }
      
    }
}
