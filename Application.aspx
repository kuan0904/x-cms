<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>

<%  dynamic pc = new JObject();

    foreach (var v in Application)
    {
        //if (s != "") s += ",";
        //s +=  "'" + v.ToString () + "':'" +  Application[v.ToString ()] + "'";
        pc.Add(v.ToString (), Application[v.ToString ()].ToString ());

    }


    //string app = JsonConvert.SerializeObject(s);
    Response.Write(pc.ToString());

    %>
