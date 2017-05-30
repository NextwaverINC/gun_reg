using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Summary description for Profile
/// </summary>
public class UserProfile
{
    public static string SessionName = "NextProfile";
    public static UserProfile getProfile()
    {
        try
        {
            UserProfile tmp = (UserProfile)HttpContext.Current.Session[SessionName];
            return tmp;
        }
        catch { return null; }
    }
    public static void setProfile(UserProfile tmp)
    {
        HttpContext.Current.Session[SessionName] = tmp;
        HttpContext.Current.Session.Timeout = 60;
    }

    public string _UserName = "";
    public string _POSITION_CODE = "";

    public UserProfile()
    {

    }
}