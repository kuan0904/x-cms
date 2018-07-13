using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
public partial class spadmin_unitdata : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Session["userid"].ToString() == ""))
        {
            Server.Transfer("login.aspx");
        }

        if ((this.IsPostBack == false))
        {
            buildtreeview(0, TreeView1.Nodes);
            Hidden_upper.Value = "0";
            upperid.DataBind();
            TreeView1.ExpandAll();

        }
    }

    void buildtreeview(int rootuid, TreeNodeCollection Nodes)
    {
        this.TreeView1.Nodes.Clear();
        this.buildchild(0, Nodes);
    }

    void buildchild(int rootuid, TreeNodeCollection Nodes)
    {
        string strsql = "";

        if ((rootuid == 0))
        {
            strsql = "SELECT * FROM unitdata  where upperid =0 and (status <> 'D' or status is null) order by sort  ";
        }
        else
        {
             strsql = "SELECT * FROM unitdata  where upperid = "
                        + rootuid + " and (status <> 'D' or status is null)  order by sort ";
        }

        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeNode newnode;
            newnode = new TreeNode();
            newnode.Text = dt.Rows[i]["unitname"].ToString();
            // newnode.NavigateUrl = "unitdata.aspx?unitid=" & rs("unitid")
            // newnode.SelectAction = TreeNodeSelectAction.Expand '�d�#P
            newnode.Value = dt.Rows[i]["unitid"].ToString();
            Nodes.Add(newnode);
            buildchild((int)dt.Rows[i]["unitid"], newnode.ChildNodes);
        }

        dt.Dispose();
    }

    protected void upperid_DataBound(object sender, System.EventArgs e)
    {
        upperid.Items.Clear();
        //走訪所有treeview節點 [不限層數]----------------
        CallRecursive(TreeView1);

        if ((upperid.Items.IndexOf(upperid.Items.FindByValue("0")) < 0))
        {
            upperid.Items.Insert(0, new ListItem("根目錄", "0"));
        }



        if ((TreeView1.SelectedValue != ""))
        {
            if (TreeView1.SelectedNode.Parent != null ){
                if ((upperid.Items.IndexOf(upperid.Items.FindByValue(TreeView1.SelectedNode.Parent.Value)) >= 0))
                {
                    upperid.SelectedValue = TreeView1.SelectedNode.Parent.Value;
                }

            }
        }
    }


    protected void TreeView1_SelectedNodeChanged(object sender, System.EventArgs e)
    {
        NameValueCollection nvc = new NameValueCollection();
        Label_Title.Text = "編輯分類";
        Panel_add.Visible = false;
        Panel_update.Visible = true;
        string strsql = ("SELECT * FROM unitdata  where unitid = \'"
                    + (TreeView1.SelectedValue + "\' order by sort  "));
        DataTable dt = DbControl.Data_Get(strsql,nvc);
        if (dt.Rows.Count >0)
        {
            unitid.Text = dt.Rows [0]["unitid"].ToString () ;
            sort.Text = dt.Rows[0]["sort"].ToString();
            unitname.Text  = (string)dt.Rows[0]["unitname"];
            linkpage.Text =   dt.Rows[0]["linkpage"].ToString();
            adminpage.Text =  dt.Rows[0]["adminpage"].ToString();

            upperid.DataBind();
        }

        dt.Dispose();
    }
    private void CallRecursive(TreeView aTreeView)
    {
        
        foreach (TreeNode n in aTreeView.Nodes)
        {
            if (n.Value != TreeView1.SelectedValue)// '父節點不能是自己或子項目
            {
                PrintRecursive(n);
            }
           
        }

    }
    private void PrintRecursive(TreeNode n)
    {
        string nodeItem = "";
        for (int i = 1; (i <= n.Depth); i++)
        {
            nodeItem += "－";
           
        }  
        nodeItem += n.Text.Trim();      
        upperid.Items.Add(new ListItem(nodeItem, n.Value));
  
        foreach (TreeNode aNode in n.ChildNodes)
        {
            if ((n.Value != TreeView1.SelectedValue))
            {
                PrintRecursive(aNode);
            }

           
        }

    }
}