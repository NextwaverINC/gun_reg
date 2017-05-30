using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class gunbook_addPage : System.Web.UI.Page
{
    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    //DataTable Table = new DataTable();
    //    //Table.Columns.Add("GunRegID");
    //    //Table.Columns.Add("GunNo");
    //    //Table.Columns.Add("GunGroup");
    //    //Table.Columns.Add("GunType");
    //    //Table.Columns.Add("GunSize");
    //    //Table.Columns.Add("GunBrand");
    //    //Table.Columns.Add("GunMaxShot");
    //    //Table.Columns.Add("GunBarrel");
    //    //Table.Columns.Add("GunColor");
    //    //Table.Columns.Add("GunOwner");
    //    //Table.Columns.Add("GunLottotal");
    //    //Table.Columns.Add("GunRemark");
    //    //Table.Columns.Add("GunRegDate");
    //    //Table.Columns.Add("GunCountry");

    //    //ViewState["DataRecordsInPage"] = Table;
    //}
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //protected void loadStores()
    //{
    //    DataTable dtRecords = (DataTable)ViewState["DataRecordsInPage"];
    //    if (dtRecords.Rows.Count > 0)
    //    {
    //        gvRecords.DataSource = dtRecords;
    //        gvRecords.DataBind();
    //    }
    //    else
    //    {
    //        dtRecords.Rows.Add(dtRecords.NewRow());
    //        gvRecords.DataSource = dtRecords;
    //        gvRecords.DataBind();
    //    }
    //}

    //protected void gridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    gvRecords.EditIndex = -1;
    //    loadStores();
    //}

    //protected void gridView_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    gvRecords.EditIndex = e.NewEditIndex;
    //    loadStores();
    //}

    //protected void gridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{
    //    string GunRegID = gvRecords.DataKeys[e.RowIndex].Values["GunRegID"].ToString();
        
    //    TextBox GunNo = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunNo");
    //    TextBox GunGroup = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunGroup");
    //    TextBox GunType = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunType");
    //    TextBox GunSize = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunSize");
    //    TextBox GunBrand = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunBrand");
    //    TextBox GunMaxShot = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunMaxShot");
    //    TextBox GunBarrel = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunBarrel");
    //    TextBox GunColor = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunColor");
    //    TextBox GunOwner = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunOwner");
    //    TextBox GunLottotal = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunLottotal");
    //    TextBox GunRemark = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunRemark");
    //    TextBox GunRegDate = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunRegDate");
    //    TextBox GunCountry = (TextBox)gvRecords.Rows[e.RowIndex].FindControl("txtGunCountry");

    //    DataTable dtRecords = (DataTable)ViewState["DataRecordsInPage"];

    //    DataRow[] dr = dtRecords.Select("GunRegID = '" + GunRegID + "'");
        
    //    dr[0]["GunNo"] = GunNo.Text;
    //    dr[0]["GunGroup"] = GunGroup.Text;
    //    dr[0]["GunType"] = GunType.Text;
    //    dr[0]["GunSize"] = GunSize.Text;
    //    dr[0]["GunBrand"] = GunBrand.Text;
    //    dr[0]["GunMaxShot"] = GunMaxShot.Text;
    //    dr[0]["GunBarrel"] = GunBarrel.Text;
    //    dr[0]["GunColor"] = GunColor.Text;
    //    dr[0]["GunOwner"] = GunOwner.Text;
    //    dr[0]["GunLottotal"] = GunLottotal.Text;
    //    dr[0]["GunRemark"] = GunRemark.Text;
    //    dr[0]["GunRegDate"] = GunRegDate.Text;
    //    dr[0]["GunCountry"] = GunCountry.Text;


    //    ViewState["DataRecordsInPage"] = dtRecords;

    //    loadStores();
    //}

    //protected void gridView_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName.Equals("AddNew"))
    //    {
    //        DataTable dtRecords = (DataTable)ViewState["DataRecordsInPage"];

    //        TextBox inGunRegID = (TextBox)gvRecords.FooterRow.FindControl("inGunRegID");
    //        TextBox inGunNo = (TextBox)gvRecords.FooterRow.FindControl("inGunNo");
    //        TextBox inGunGroup = (TextBox)gvRecords.FooterRow.FindControl("inGunGroup");
    //        TextBox inGunType = (TextBox)gvRecords.FooterRow.FindControl("inGunType");
    //        TextBox inGunSize = (TextBox)gvRecords.FooterRow.FindControl("inGunSize");
    //        TextBox inGunBrand = (TextBox)gvRecords.FooterRow.FindControl("inGunBrand");
    //        TextBox inGunMaxShot = (TextBox)gvRecords.FooterRow.FindControl("inGunMaxShot");
    //        TextBox inGunBarrel = (TextBox)gvRecords.FooterRow.FindControl("inGunBarrel");
    //        TextBox inGunColor = (TextBox)gvRecords.FooterRow.FindControl("inGunColor");
    //        TextBox inGunOwner = (TextBox)gvRecords.FooterRow.FindControl("inGunOwner");
    //        TextBox inGunLottotal = (TextBox)gvRecords.FooterRow.FindControl("inGunLottotal");
    //        TextBox inGunRemark = (TextBox)gvRecords.FooterRow.FindControl("inGunRemark");
    //        TextBox inGunRegDate = (TextBox)gvRecords.FooterRow.FindControl("inGunRegDate");
    //        TextBox inGunCountry = (TextBox)gvRecords.FooterRow.FindControl("inGunCountry");

    //        DataRow dr = dtRecords.NewRow();

    //        dr["GunRegID"] = inGunRegID.Text;
    //        dr["GunNo"] = inGunNo.Text;
    //        dr["GunGroup"] = inGunGroup.Text;
    //        dr["GunType"] = inGunType.Text;
    //        dr["GunSize"] = inGunSize.Text; 
    //        dr["GunBrand"] = inGunBrand.Text;
    //        dr["GunMaxShot"] = inGunMaxShot.Text;
    //        dr["GunBarrel"] = inGunBarrel.Text;
    //        dr["GunColor"] = inGunColor.Text;
    //        dr["GunOwner"] = inGunOwner.Text;
    //        dr["GunLottotal"] = inGunLottotal.Text;
    //        dr["GunRemark"] = inGunRemark.Text;
    //        dr["GunRegDate"] = inGunRegDate.Text;
    //        dr["GunCountry"] = inGunCountry.Text;

    //        dtRecords.Rows.Add(dr);

    //        ViewState["DataRecordsInPage"] = dtRecords;
    //        loadStores();
    //    }
    //}

    //protected void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        string GunRegID = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "GunRegID"));
    //        Button lnkbtnresult = (Button)e.Row.FindControl("ButtonDelete");
    //        if (lnkbtnresult != null)
    //        {
    //            lnkbtnresult.Attributes.Add("onclick", "javascript:return deleteConfirm('" + GunRegID + "')");
    //        }
    //    }
    //}

    //protected void gridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
    //    string GunRegID = gvRecords.DataKeys[e.RowIndex].Values["GunRegID"].ToString();

    //    DataTable dtRecords = (DataTable)ViewState["DataRecordsInPage"];

    //    DataRow[] dr = dtRecords.Select("GunRegID = '" + GunRegID + "'");
    //    dr[0].Delete();
    //    //for (int i = dtRecords.Rows.Count - 1; i >= 0; i--)
    //    //{
    //    //    DataRow dr = dtRecords.Rows[i];
    //    //    if (dr["GunRegID"] == GunRegID)
    //    //        dr.Delete();
    //    //}
    //    ViewState["DataRecordsInPage"] = dtRecords;

    //    loadStores();
    //}
}